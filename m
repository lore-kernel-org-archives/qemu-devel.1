Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AEDCA9EC0
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 02:45:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1B3320679
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 02:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZkISNiTA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B3320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPHW3-0004bw-Sk
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 22:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54571)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1iPHPu-0005K2-Sg
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 22:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1iPHJq-0006WX-6I
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 22:33:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53119
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1iPHJq-0006WK-2i
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 22:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572316393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uMQh/z/4zNi4pb3O1lvaEVdD7Tj24v15+tFCaEuXjoA=;
 b=ZkISNiTAE9Fgl2pPOvi+rp5HH27zAOm9XQqIoTdLC8pnMlVltv+Eqq3NPOYdTir+Pc8Czb
 SRKrK0MwHX4n+ikiqphila0SQFGtfKE5BO3Uxhcck4brWhT+quMnx+R6Baodn0vBWEZk7/
 0nonkF8jITdcahzq7VBD6bIbjA9bOic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-dQ5PBxd8NkOKmSGRbLzAQw-1; Mon, 28 Oct 2019 22:33:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2284A801E64;
 Tue, 29 Oct 2019 02:33:09 +0000 (UTC)
Received: from [10.72.12.223] (ovpn-12-223.pek2.redhat.com [10.72.12.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A416960856;
 Tue, 29 Oct 2019 02:33:07 +0000 (UTC)
Subject: Re: [PULL 0/4] Net patches
To: Peter Maydell <peter.maydell@linaro.org>
References: <1572244520-14737-1-git-send-email-jasowang@redhat.com>
 <CAFEAcA8c2zCDgP=zbzXs7s=4xT_oB8c7ndgn-qacXzepATuo0A@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2fea0983-c5ed-1713-1958-649f5a80745c@redhat.com>
Date: Tue, 29 Oct 2019 10:33:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8c2zCDgP=zbzXs7s=4xT_oB8c7ndgn-qacXzepATuo0A@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: dQ5PBxd8NkOKmSGRbLzAQw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Sven Schnelle <svens@stackframe.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/10/29 =E4=B8=8A=E5=8D=885:42, Peter Maydell wrote:
> On Mon, 28 Oct 2019 at 06:35, Jason Wang <jasowang@redhat.com> wrote:
>> The following changes since commit 187f35512106501fe9a11057f4d8705431e00=
26d:
>>
>>    Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-next-=
251019-3' into staging (2019-10-26 10:13:48 +0100)
>>
>> are available in the git repository at:
>>
>>    https://github.com/jasowang/qemu.git tags/net-pull-request
>>
>> for you to fetch changes up to 5af982a47cf6b6cd9beb872e5a9b940e43df5bf9:
>>
>>    COLO-compare: Fix incorrect `if` logic (2019-10-28 14:28:31 +0800)
>>
>> ----------------------------------------------------------------
>>
>> ----------------------------------------------------------------
> Hi -- I get this compile failure on some hosts (s390, aarch64,
> aarch32, ppc):
>
> /home/pm215/qemu/hw/net/tulip.c: In function =E2=80=98tulip_idblock_crc=
=E2=80=99:
> /home/pm215/qemu/hw/net/tulip.c:859:9: error: comparison is always
> true due to limited range of data type [-Werror=3Dtype-limits]
>           for (bit =3D 15; bit >=3D 0; bit--) {
>           ^
>
> 'bit' here is of type char, which can be either signed
> or unsigned depending on the host. If it's unsigned
> (as is the case on the above architectures), then the
> loop will never terminate because "bit >=3D 0" is always true.
> Plain old 'int' is probably a better choice anyway.


Yes, will fix and post V2.

Thanks


>
> thanks
> -- PMM
>


