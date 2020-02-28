Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3ABC3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 14:51:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98BB52469D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 14:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KJe7nw0K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98BB52469D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7gyp-0002gH-PT
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 09:51:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39440)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j7gxv-0001uv-UE
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 09:50:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j7gxu-0001ZH-Jr
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 09:50:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54872
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j7gxu-0001Wp-F9
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 09:50:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582901407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vm/HGI5r4FLAY6zJYHC901AG7U+WHBTXmP3k/OmCNrc=;
 b=KJe7nw0KH81r1cIQWVilf4yAQ/4aQghDu57HXQ4CCrZ5sbF9mJTDDVFEZHUFU/+gdUTvxu
 A5qDUM0O1HTAM3LqkKwDNKWVNu99NtQ/ZpATgHkUxyfR4MNYflNWpjgkCm3dm30IiVB54O
 hzVB1cegdhN4Ssid3Am1yIal76yzWlE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-7iDE79IOM2KiX5NLfemoEQ-1; Fri, 28 Feb 2020 09:50:01 -0500
X-MC-Unique: 7iDE79IOM2KiX5NLfemoEQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E33B9A0CC3;
 Fri, 28 Feb 2020 14:49:59 +0000 (UTC)
Received: from [10.36.116.59] (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9203860BE0;
 Fri, 28 Feb 2020 14:49:52 +0000 (UTC)
Subject: Re: [PATCH v4 00/10] vTPM for aarch64
To: Stefan Berger <stefanb@linux.ibm.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20200226205942.11424-1-eric.auger@redhat.com>
 <4fb16117-f9d3-61af-9198-931590a46e3d@linux.ibm.com>
 <ee98e8ab-06df-e422-1ca5-f3f6a48145f2@redhat.com>
 <2413ead7-3707-acc6-7900-bb3896082051@linux.ibm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <8ae6ca7b-34b5-b752-2bfd-4b7c2c9663f5@redhat.com>
Date: Fri, 28 Feb 2020 15:49:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <2413ead7-3707-acc6-7900-bb3896082051@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: marcandre.lureau@redhat.com, lersek@redhat.com, ardb@kernel.org,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,
On 2/28/20 3:37 PM, Stefan Berger wrote:
> On 2/27/20 3:07 AM, Auger Eric wrote:
>> Hi Stefan,
>> On 2/26/20 11:44 PM, Stefan Berger wrote:
>>> On 2/26/20 3:59 PM, Eric Auger wrote:
>>>> This series adds the capability to instantiate an MMIO TPM TIS
>>>> in ARM virt. It is candidate to qemu 5.0.
>>> I queued it now here:
>>> https://github.com/stefanberger/qemu-tpm/commits/tpm-next
>>>
>>> I will send the PR within a few days. Thanks!
>> Thank you. I will just ping Peter to make sure he has no comments on
>>
>> [PATCH v4 06/10] hw/arm/virt: vTPM support
>=20
>=20
> The little dent is now an arm boot failure:
>=20
>=20
> https://travis-ci.org/stefanberger/qemu-tpm/jobs/655573347?utm_medium=3Dn=
otification&utm_source=3Demail
is this really related to the sysbus TPM-TIS addition? I have the
impression cubieboard acceptance tests (ARM 32b) are failing. I touched
ARM virt machine.

Thanks

Eric
>=20
>=20
>=20
> Have a look at the raw log.
>=20
>=20
> =C2=A0=C2=A0 Stefan
>=20
>=20
>=20


