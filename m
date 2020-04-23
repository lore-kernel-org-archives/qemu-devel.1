Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFABC54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 15:59:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CF4C20728
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 15:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cyttt7J9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CF4C20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jReFt-00033Z-Qu
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 11:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jReEz-0001s7-AU
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:58:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jReEy-0000eO-4s
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:58:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23895
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jReEx-0000dj-J2
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587657494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aVhZKRLVOacYyjJl14HA11Tb74iIOkYd2CYw3GS5o8o=;
 b=Cyttt7J9EwwX8bltbpLY+wwZZX0yRcexkNQCrmwqd40UdwTpZFCXQnxd6sW1k1IyYDUnTf
 6tFfLvIXL6RBXofN7OYYVUBuFNBFY5wlLzMSTbUSsgLJlpZZxNQ1QVomowTrYJeGzChwA/
 1KOM74kET9mQDu1ZdTHKqIkPzBo29PY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-sUDwRd6FOL-1YgX3tOxIiA-1; Thu, 23 Apr 2020 11:58:12 -0400
X-MC-Unique: sUDwRd6FOL-1YgX3tOxIiA-1
Received: by mail-wr1-f69.google.com with SMTP id s11so3093946wru.6
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 08:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iMt8jG3w6p3v3A4cVNT+8mC6wu129q04neC8fMe7oGs=;
 b=DPEQMXorqjQELcuvKL3kaw0XtIl8150ZCodypcYdSHgf8goDuY3pthe5khOAjr5jyb
 L9maKVz2jAqr6NTr3pBf0sgfzJpU4WEF1SsYSrT3QF58v79FK+sS8MWt7IxsuueK4jct
 gNty00bSP+dzNo3lYtIS6bqGVLouBTmq9PmDxxOLsumXqoJqJA7KFK0CR2dESsBRGIOM
 6Eqo/HhqRdZlXG7nVm8XC42/VxttDHhqBmpVwiDx9lG4KRlc1/p4jkAbJ5b54Q5bZ+c6
 O3WcD5m3++S8UdsBCqhCc5FZtHd/3aB/fo1cTlHIr2oNgC8szxo/FFZQPU4zBznwJPdn
 wW2g==
X-Gm-Message-State: AGi0PuaORpsvl973iIbtge6wkhpOcAPOV3lI6A+va4YzuAT8LwuNAFVK
 TAblISqJXFSchc1/0/+3fcXusf3TkFVNsjuG1w3aK3+w/TttzrmtJGP6MzxQHLEZowCRVRClsXr
 lW9mrj24r/eAQ7Fo=
X-Received: by 2002:a5d:42c7:: with SMTP id t7mr5598379wrr.336.1587657491019; 
 Thu, 23 Apr 2020 08:58:11 -0700 (PDT)
X-Google-Smtp-Source: APiQypKopCcl7n7qdIBvdj5fJQFzGMn15uroFw/6nMfKAHmPmFh6cUYELmOfLvg5VnNwVX6h7Tq6Dw==
X-Received: by 2002:a5d:42c7:: with SMTP id t7mr5598341wrr.336.1587657490798; 
 Thu, 23 Apr 2020 08:58:10 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id s11sm4573001wrw.71.2020.04.23.08.58.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2020 08:58:09 -0700 (PDT)
Subject: Re: [PATCH RESEND v6 06/36] monitor: destaticize HMP commands
To: Jag Raman <jag.raman@oracle.com>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <3dc3603df5b83576c7ec65589f144d44419cee52.1587614626.git.elena.ufimtseva@oracle.com>
 <3cca22d6-349c-10e0-c0ff-9c75f32e56e2@redhat.com>
 <517D1E24-5BA3-4ADB-B1A2-5B083C9201A2@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <57ba9576-b599-e36b-3655-ab63ddd32413@redhat.com>
Date: Thu, 23 Apr 2020 17:58:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <517D1E24-5BA3-4ADB-B1A2-5B083C9201A2@oracle.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 05:42:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, fam@euphon.net,
 swapnil.ingle@nutanix.com, john.g.johnson@oracle.com, qemu-devel@nongnu.org,
 kraxel@redhat.com, quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, pbonzini@redhat.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/23/20 5:07 PM, Jag Raman wrote:
>> On Apr 23, 2020, at 10:14 AM, Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com> wrote:
>>
>> Why 'destaticize HMP commands=E2=80=99?
>=20
> Hi Philippe,
>=20
> Both QEMU & the remote process links the QMP code. QEMU uses
> all of the QMP commands, whereas, the remote process only uses a
> subset of this. Therefore, the =E2=80=98static=E2=80=99 functions which d=
on=E2=80=99t have a
> reference cause build errors (like defined but not used). Therefore,
> we decided to destaticize the ones that are causing the build failure.

If you explain it, it is understandable. Worth a note in the commit=20
description then :)

>=20
> On a different note, Dave had previously suggested destacizing only the
> HMP functions used by the remote process. However, we found out that this=
 is
> not possible because without all these functions, the build error still r=
eproduces.
> We did confirm that all the functions we have destaticized are necessary =
to
> help with build of the remote process.
>=20
> Thank you very much!
> --
> Jag
>=20
>>
>> On 4/23/20 6:13 AM, elena.ufimtseva@oracle.com wrote:
>>> From: Jagannathan Raman <jag.raman@oracle.com>
>>> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>>> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
>>> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
>>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>> ---
>>>   hmp-commands.hx            |  4 +-
>>>   monitor/misc.c             | 76 +++++++++++++++++++------------------=
-
>>>   monitor/monitor-internal.h | 38 +++++++++++++++++++
>>>   3 files changed, 78 insertions(+), 40 deletions(-)
>>
>=20


