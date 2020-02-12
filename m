Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4EFC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:48:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DD0120714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyhBYJWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD0120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1vBL-0006Ew-8w
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 11:48:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37187)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1vAJ-00053o-V7
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:47:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1vAG-0008JH-Lc
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:47:06 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51867
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1vAG-0008Hp-By
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:47:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581526023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i9ERlf2ATQkWFPx/pWxqo6/d+5NangutUBn7byhmPYw=;
 b=gyhBYJWzfq7qXRdcNXjDWlKg5S0yaHTRICJjLnj82e83Pw3btpjYHBsv5K+PlBEx4mz5wy
 OY0a/EK7OCTKVnNpYLTO46UbLZ5f7cOnwELYeZSQAHcPdwuKufnSKnTXFwyZ44cBGY8No4
 SIftRsE6NYkBl5F7rFAH9zjCLPo8ZDw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-HVtyGMJIPtmEYvWWNqZ8dg-1; Wed, 12 Feb 2020 11:46:54 -0500
Received: by mail-wr1-f69.google.com with SMTP id j4so1048881wrs.13
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 08:46:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZjUcJBzk9qFn3b+ddu5t0S4030WrN6jPrEt0eqDYmEQ=;
 b=sg+iSVS2D9ogFI7Z01iTFEetpRivtoAN/JnmvUrowX81cVw7x7sA1r7nkhSpov2XYJ
 /SVg6ei9d5TUAVSZ7z3E6H8PctUN/an1thq0buz5Renr4sPJ7pY+fTwnVrZjCh+mQLAh
 yjGJxZIqUSOSWN1Q9Q00NuuA+6wktigt3Jgn3R0DL65qzyrJmVhHLWLA0VKYEKb3ohaH
 TVGI0VMLH39KQZ22L33Za8Fnelvk7VffGMOw118JSPIeYKzlJpB9udWGccnel5RJpxyZ
 jMDNkpe30T8ItXhM/sO01xRBUpfNPSaKUJrKNUQAShWwQsHtJf2yikNQdcbGYIEyMPxj
 ZPCw==
X-Gm-Message-State: APjAAAVrwfUMBuIkBMD09cRNyglnYbLicJWK6p+n4oymPy8J/RFo5y7B
 7BGfD0qdrDcHPs9JXLUumx8wB/xmJfV2EQO4OHLa1gaH8j3GOnUuHLRuk8UerBD/6dzPgegUXzd
 +ssCYmY6abLHMrfE=
X-Received: by 2002:adf:9c8d:: with SMTP id d13mr17032040wre.392.1581526012851; 
 Wed, 12 Feb 2020 08:46:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqx2w9k4gDVIThRLKMi3k5AdEtgRTj8ESKvdOzS8yqzCcOf/+C57QVaCGWvEF5counItQ9Dt1A==
X-Received: by 2002:adf:9c8d:: with SMTP id d13mr17032012wre.392.1581526012524; 
 Wed, 12 Feb 2020 08:46:52 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id r6sm1189479wrq.92.2020.02.12.08.46.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2020 08:46:52 -0800 (PST)
Subject: Re: [PATCH v2] linux-user: implement TARGET_SO_PEERSEC
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200204211901.1731821-1-laurent@vivier.eu>
 <713318de-21ee-4137-0580-c6d852bea008@redhat.com>
 <93a00c06-f42d-0c7d-79a4-0dcd1bc488c5@vivier.eu>
 <67dbdf8f-0565-32f0-bfeb-0ca7d694d948@redhat.com>
 <a873c241-ffc0-1023-7d2a-d6f08c463bf6@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <af1a7b51-25d0-301d-1bc1-632c568b52a1@redhat.com>
Date: Wed, 12 Feb 2020 17:46:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <a873c241-ffc0-1023-7d2a-d6f08c463bf6@vivier.eu>
Content-Language: en-US
X-MC-Unique: HVtyGMJIPtmEYvWWNqZ8dg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?Q?Matthias_L=c3=bcscher?= <lueschem@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/12/20 5:43 PM, Laurent Vivier wrote:
> Le 12/02/2020 =C3=A0 17:08, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit=C2=
=A0:
>> On 2/12/20 5:03 PM, Laurent Vivier wrote:
>>> Le 12/02/2020 =C3=A0 16:56, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit=C2=
=A0:
>>>> On 2/4/20 10:19 PM, Laurent Vivier wrote:
>>>>> "The purpose of this option is to allow an application to obtain the
>>>>> security credentials of a Unix stream socket peer.=C2=A0 It is analog=
ous to
>>>>> SO_PEERCRED (which provides authentication using standard Unix
>>>>> credentials
>>>>> of pid, uid and gid), and extends this concept to other security
>>>>> models." -- https://lwn.net/Articles/62370/
>>>>>
>>>>> Until now it was passed to the kernel with an "int" argument and
>>>>> fails when it was supported by the host because the parameter is
>>>>> like a filename: it is always a \0-terminated string with no embedded
>>>>> \0 characters, but is not guaranteed to be ASCII or UTF-8.
>>>>>
>>>>> I've tested the option with the following program:
>>>>>
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * cc -o getpeercon getpeercon.c
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #include <stdio.h>
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #include <sys/types.h>
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #include <sys/socket.h>
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #include <netinet/in.h>
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #include <arpa/inet.h>
>>>>>
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int main(void)
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int fd;
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sockad=
dr_in server, addr;
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 socklen_t len=
;
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char buf[256]=
;
>>>>>
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fd =3D socket=
(PF_INET, SOCK_STREAM, 0);
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (fd =3D=3D=
 -1) {
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 perror("socket");
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return 1;
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 server.sin_fa=
mily =3D AF_INET;
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inet_aton("12=
7.0.0.1", &server.sin_addr);
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 server.sin_po=
rt =3D htons(40390);
>>>>>
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 connect(fd, (=
struct sockaddr*)&server, sizeof(server));
>>>>>
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 len =3D sizeo=
f(buf);
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D getso=
ckopt(fd, SOL_SOCKET, SO_PEERSEC, buf, &len);
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret =3D=
=3D -1) {
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 perror("getsockopt");
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return 1;
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("%d %s=
\n", len, buf);
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>
>>>>> On host:
>>>>>
>>>>>  =C2=A0=C2=A0=C2=A0 $ ./getpeercon
>>>>>  =C2=A0=C2=A0=C2=A0 33 system_u:object_r:unlabeled_t:s0
>>>>>
>>>>> With qemu-aarch64/bionic without the patch:
>>>>>
>>>>>  =C2=A0=C2=A0=C2=A0 $ ./getpeercon
>>>>>  =C2=A0=C2=A0=C2=A0 getsockopt: Numerical result out of range
>>>>>
>>>>> With the patch:
>>>>>
>>>>>  =C2=A0=C2=A0=C2=A0 $ ./getpeercon
>>>>>  =C2=A0=C2=A0=C2=A0 33 system_u:object_r:unlabeled_t:s0
>>>>>
>>>>> Bug: https://bugs.launchpad.net/qemu/+bug/1823790
>>>>> Reported-by: Matthias L=C3=BCscher <lueschem@gmail.com>
>>>>> Tested-by: Matthias L=C3=BCscher <lueschem@gmail.com>
>>>>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>>>>> ---
>>>>>
>>>>> Notes:
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v2: use correct length in unlock_user=
()
>>>>>
>>>>>  =C2=A0=C2=A0 linux-user/syscall.c | 22 ++++++++++++++++++++++
>>>>>  =C2=A0=C2=A0 1 file changed, 22 insertions(+)
>>>>>
>>>>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>>>>> index d60142f0691c..c930577686da 100644
>>>>> --- a/linux-user/syscall.c
>>>>> +++ b/linux-user/syscall.c
>>>>> @@ -2344,6 +2344,28 @@ static abi_long do_getsockopt(int sockfd, int
>>>>> level, int optname,
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 }
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 break;
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case TARGET_SO_PEERSEC: {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
har *name;
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (get_user_u32(len, optlen)) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return -TARGET_EFAULT;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (len < 0) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return -TARGET_EINVAL;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 n=
ame =3D lock_user(VERIFY_WRITE, optval_addr, len, 0);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (!name) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return -TARGET_EFAULT;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l=
v =3D len;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
et =3D get_errno(getsockopt(sockfd, level, SO_PEERSEC,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 name, &lv));
>>>>
>>>> Can we get lv > len?
>>>
>>> No:
>>>
>>> getsockopt(2)
>>>
>>> "For=C2=A0 getsockopt(), optlen is a value-result argument, initially
>>> containing the size of the buffer pointed to by optval, and modified on
>>> return to=C2=A0 indicate the=C2=A0 actual=C2=A0 size=C2=A0 of=C2=A0 the=
 value returned."
>>>
>>>>
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (put_user_u32(lv, optlen)) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -TARGET_EFAULT;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u=
nlock_user(name, optval_addr, lv);
>>>>
>>>> Maybe safer to use len instead of lv here?
>>>
>>> No:
>>>
>>> this is the length of the buffer we must copy back to the user. Kernel
>>> has only modified lv length, not len.
>>
>> So we can simplify the TARGET_SO_LINGER case then.
>=20
> No, this case is different because lglen is sizeof(struct linger) and it
> can differ from len. So lglen can be greater than len.
>=20
> If you check the kernel you can see if the buffer is not big enough the
> data are partially copied. This is partially done in our code because
> the __put_user() can overflow the user memory but we return len to the
> caller. To fix that, we should use a local target_linger to change
> endianness and then copy the local copy to the user copy using len.

Ah OK I understand now, thanks for the explanation.

>=20
>>>
>>> linux-user/qemu.h
>>>
>>> /* Unlock an area of guest memory.=C2=A0 The first LEN bytes must be
>>>  =C2=A0=C2=A0=C2=A0 flushed back to guest memory. host_ptr =3D NULL is =
explicitly
>>>  =C2=A0=C2=A0=C2=A0 allowed and does nothing. */
>>> static inline void unlock_user(void *host_ptr, abi_ulong guest_addr,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 long len)
>>>
>>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>
>=20
> Thank you.
>=20
> Laurent
>=20


