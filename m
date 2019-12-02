Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8187AC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 10:45:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49F60214AF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 10:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WHSthr7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F60214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibjD7-0002XZ-GR
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 05:45:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ibjCF-0001ha-Sq
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:44:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ibjCC-0005rQ-DQ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:44:49 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53410
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ibjCC-0005r2-3B
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:44:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575283487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=Hxk0P9xjFNoIf6TMiR+0tBjt0ttDOY+430btj20+V24=;
 b=WHSthr7Iz1kq3hwenhG8s9Wzpe3Yj0XnC+k4Lhj9epmY9T/YHVIRkwKLNLeBg0x7vslEKN
 sX1ILsO9weyR8akCaOiD8atIW0u+ncpM3l6+WQ5QMzi+7es/53+y5RaPp+axoxPsqWbzot
 9rDXvOsRbghR9cszw0wR4k0zSAK7gyA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-w9baJtxUMzqiLggqBFVc6w-1; Mon, 02 Dec 2019 05:44:45 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECEFB800D41;
 Mon,  2 Dec 2019 10:44:44 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-196.ams2.redhat.com [10.36.117.196])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 58B6B60BFB;
 Mon,  2 Dec 2019 10:44:41 +0000 (UTC)
Subject: Re: [PATCH] ci: Use libcap-ng
To: Greg Kurz <groug@kaod.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>
References: <20191129142126.32967-1-dgilbert@redhat.com>
 <3297c897-69ab-c30f-98dd-dd3138e6325b@redhat.com>
 <20191202114125.2ab5783d@bahia.w3ibm.bluemix.net>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <87c87c3c-d215-e380-3ac3-b43125f5ffa7@redhat.com>
Date: Mon, 2 Dec 2019 11:44:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191202114125.2ab5783d@bahia.w3ibm.bluemix.net>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: w9baJtxUMzqiLggqBFVc6w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: pbonzini@redhat.com, "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/12/2019 11.41, Greg Kurz wrote:
> On Fri, 29 Nov 2019 16:51:29 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>=20
>> On 11/29/19 3:21 PM, Dr. David Alan Gilbert (git) wrote:
>>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>>
>>> We currently enable libcap-dev in build-clang to pick up the 9p proxy
>>> helper.  Paolo's patch changes that to use libcap-ng, so switch to usin=
g
>>
>> It is not obvious you are referring to "virtfs-proxy-helper: switch from=
=20
>> libcap to libcap-ng" he recently posted.
>>
>> Since Greg is going to take Paolo's patch, I'd suggest he also takes=20
>> this one, so he can update the commit description with either "the=20
>> previous patch" or the commit sha1.
>>
>=20
> I'm okay to take this one and to adapt the changelog if I get an ack from
> Thomas.

Feel free to recycle my Ack from here:

https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg05178.html

 Cheers,
  Thomas


