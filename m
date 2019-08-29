Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DEAC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 15:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B05282166E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 15:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B05282166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3MbQ-0004I5-Uc
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 11:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58788)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i3Mad-0003fn-Hs
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:44:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i3Maa-0002Gt-Vp
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:43:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46720)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i3Maa-0002Fp-NH
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:43:56 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1976B3B707
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 15:43:55 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id 10so1381873wmi.8
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 08:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DbmYiLWhyR0MdbIsHNV7MCA8gNc7FNPXLTXZQaYzto8=;
 b=JEw8imyLG6Kp9HYZ1Mu6Zu44gPjl9nXemD9tbNeC+eDUUckFssFfJQwKjQWxFSp/lu
 22Z87bMEuldMHPIqHtsvaKD543DxztzAL5iDvOIviEcJvmnfX5aDBI2ArF7+vFBVjF8f
 BoQGwijFeG2y21SaKpTIDTNcuIq8uk2yEdmbTicVNuSO9fzFKWWGPOXeFmzHE0XrdiI8
 Ay2AYHMSwnhca7XEdQerbqehPH6Xel+a4lp4NTYV4C30+t0LK5D3Q6dmr6Z7qmTJzB5u
 NjHuRh0s5CxCmPN0KSA+SMvFJvObeoMVYe/fQYJHIHZpFhgOJNDL5MSrqaxoMpveBLp6
 NP3w==
X-Gm-Message-State: APjAAAWG1fAG20eu/VW/S+vD+9SBvQrnBRgdYsEEASuGZZskMtZVqibm
 JuD7jnRt1UarMS/DBwgNXwbAPSsxfyms5PDRrvhPXuanOIRj9AFVFG3F4AZfKfz1pwn6812ThzK
 pNkU86NCNVsWVjNU=
X-Received: by 2002:a7b:ce8f:: with SMTP id q15mr5961369wmj.154.1567093433760; 
 Thu, 29 Aug 2019 08:43:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzvEERAT04JbHnR8UWRChQC0M+SQxCe3ePvWq8bEhrUL4N8DuQiCJKSlOk3WwkAgrEXIfnw6g==
X-Received: by 2002:a7b:ce8f:: with SMTP id q15mr5961342wmj.154.1567093433508; 
 Thu, 29 Aug 2019 08:43:53 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id q19sm2843978wra.89.2019.08.29.08.43.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2019 08:43:52 -0700 (PDT)
To: Samuel Thibault <samuel.thibault@gnu.org>, slirp@lists.freedesktop.org,
 Petr Matousek <pmatouse@redhat.com>, Vishnu Dev TJ <vishnudevtj@gmail.com>,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 Prasad J Pandit <ppandit@redhat.com>
References: <20190822144134.23521-1-philmd@redhat.com>
 <20190822144134.23521-2-philmd@redhat.com>
 <20190822183313.pptfwjsnrpdi6tfp@function>
 <14216968-a066-6abf-1952-3cff3aa3eee3@redhat.com>
 <20190825225403.vwg2fhfff6i7gnwd@function>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a032c557-7f1e-c710-f25a-e42200f0cf91@redhat.com>
Date: Thu, 29 Aug 2019 17:43:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190825225403.vwg2fhfff6i7gnwd@function>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Slirp] [PATCH 1/2] Do not reassemble fragments
 pointing outside of the original payload
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Samuel,

On 8/26/19 12:54 AM, Samuel Thibault wrote:
> Hello,
>=20
> Philippe Mathieu-Daud=E9, le ven. 23 ao=FBt 2019 17:15:32 +0200, a ecri=
t:
>>> Did you make your test with commit 126c04acbabd ("Fix heap overflow i=
n
>>> ip_reass on big packet input") applied?
>>
>> Yes, unfortunately it doesn't fix the issue.
>=20
> Ok.
>=20
> Could you try the attached patch?  There was a use-after-free.  Without
> it, I can indeed crash qemu with the given exploit.  With it I don't
> seem to be able to crash it (trying in a loop for several minutes).

No change with your patch applied:

Thread 4 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7fffe94c4700 (LWP 14031)]
0x0000555555e835c5 in icmp_input (m=3D0x0, hlen=3D20) at
qemu/slirp/src/ip_icmp.c:130
130         register struct ip *ip =3D mtod(m, struct ip *);
(gdb) bt
#0  0x0000555555e835c5 in icmp_input (m=3D0x0, hlen=3D20) at
qemu/slirp/src/ip_icmp.c:130
#1  0x0000555555e85450 in ip_input (m=3D0x0) at qemu/slirp/src/ip_input.c=
:205
#2  0x0000555555e723d2 in slirp_input (slirp=3D0x555556708170,
pkt=3D0x55555727fab0 "", pkt_len=3D1314) at qemu/slirp/src/slirp.c:785
#3  0x0000555555c83961 in net_slirp_receive (nc=3D0x555556707fa0,
buf=3D0x55555727fab0 "", size=3D1314) at qemu/net/slirp.c:126
#4  0x0000555555c788cb in nc_sendv_compat (nc=3D0x555556707fa0,
iov=3D0x7fffe94c0930, iovcnt=3D1, flags=3D0) at qemu/net/net.c:700
#5  0x0000555555c7898d in qemu_deliver_packet_iov
(sender=3D0x5555566a6440, flags=3D0, iov=3D0x7fffe94c0930, iovcnt=3D1,
opaque=3D0x555556707fa0) at qemu/net/net.c:728
#6  0x0000555555c7b49d in qemu_net_queue_deliver_iov
(queue=3D0x5555566a6260, sender=3D0x5555566a6440, flags=3D0,
iov=3D0x7fffe94c0930, iovcnt=3D1) at qemu/net/queue.c:179
#7  0x0000555555c7b60c in qemu_net_queue_send_iov (queue=3D0x5555566a6260=
,
sender=3D0x5555566a6440, flags=3D0, iov=3D0x7fffe94c0930, iovcnt=3D1,
sent_cb=3D0x0) at qemu/net/queue.c:224
#8  0x0000555555c78ad2 in qemu_sendv_packet_async
(sender=3D0x5555566a6440, iov=3D0x7fffe94c0930, iovcnt=3D1, sent_cb=3D0x0=
) at
qemu/net/net.c:769
#9  0x0000555555c78aff in qemu_sendv_packet (nc=3D0x5555566a6440,
iov=3D0x7fffe94c0930, iovcnt=3D1) at qemu/net/net.c:777
#10 0x0000555555c7c038 in net_hub_receive_iov (hub=3D0x5555566b1ab0,
source_port=3D0x5555566a67a0, iov=3D0x7fffe94c0930, iovcnt=3D1) at
qemu/net/hub.c:74
#11 0x0000555555c7c232 in net_hub_port_receive_iov (nc=3D0x5555566a67a0,
iov=3D0x7fffe94c0930, iovcnt=3D1) at qemu/net/hub.c:125
#12 0x0000555555c78972 in qemu_deliver_packet_iov
(sender=3D0x555557292860, flags=3D0, iov=3D0x7fffe94c0930, iovcnt=3D1,
opaque=3D0x5555566a67a0) at qemu/net/net.c:726
#13 0x0000555555c7b421 in qemu_net_queue_deliver (queue=3D0x5555566a6940,
sender=3D0x555557292860, flags=3D0, data=3D0x55555727fab0 "", size=3D1314=
) at
qemu/net/queue.c:164
#14 0x0000555555c7b53d in qemu_net_queue_send (queue=3D0x5555566a6940,
sender=3D0x555557292860, flags=3D0, data=3D0x55555727fab0 "", size=3D1314=
,
sent_cb=3D0x0) at qemu/net/queue.c:199
#15 0x0000555555c78733 in qemu_send_packet_async_with_flags
(sender=3D0x555557292860, flags=3D0, buf=3D0x55555727fab0 "", size=3D1314=
,
sent_cb=3D0x0) at qemu/net/net.c:654
#16 0x0000555555c7876b in qemu_send_packet_async (sender=3D0x555557292860=
,
buf=3D0x55555727fab0 "", size=3D1314, sent_cb=3D0x0) at qemu/net/net.c:66=
1
#17 0x0000555555c78798 in qemu_send_packet (nc=3D0x555557292860,
buf=3D0x55555727fab0 "", size=3D1314) at qemu/net/net.c:667
#18 0x0000555555b32b67 in e1000_send_packet (s=3D0x55555725ce00,
buf=3D0x55555727fab0 "", size=3D1314) at qemu/hw/net/e1000.c:552
#19 0x0000555555b32fd3 in xmit_seg (s=3D0x55555725ce00) at
qemu/hw/net/e1000.c:615
#20 0x0000555555b33503 in process_tx_desc (s=3D0x55555725ce00,
dp=3D0x7fffe94c0b70) at qemu/hw/net/e1000.c:702
#21 0x0000555555b336fb in start_xmit (s=3D0x55555725ce00) at
qemu/hw/net/e1000.c:757
#22 0x0000555555b347b5 in set_tctl (s=3D0x55555725ce00, index=3D3590, val=
=3D8)
at qemu/hw/net/e1000.c:1128
#23 0x0000555555b34932 in e1000_mmio_write (opaque=3D0x55555725ce00,
addr=3D14360, val=3D8, size=3D4) at qemu/hw/net/e1000.c:1304
#24 0x000055555585b126 in memory_region_write_accessor
(mr=3D0x55555725f700, addr=3D14360, value=3D0x7fffe94c0cd8, size=3D4, shi=
ft=3D0,
mask=3D4294967295, attrs=3D...) at qemu/memory.c:507
#25 0x000055555585b336 in access_with_adjusted_size (addr=3D14360,
value=3D0x7fffe94c0cd8, size=3D4, access_size_min=3D4, access_size_max=3D=
4,
access_fn=3D0x55555585b03d <memory_region_write_accessor>,
mr=3D0x55555725f700, attrs=3D...)
    at qemu/memory.c:573
#26 0x000055555585e315 in memory_region_dispatch_write
(mr=3D0x55555725f700, addr=3D14360, data=3D8, size=3D4, attrs=3D...) at
qemu/memory.c:1509
#27 0x00005555557fcee2 in flatview_write_continue (fv=3D0x7fffe02307f0,
addr=3D4273747992, attrs=3D..., buf=3D0x7ffff7fcb028 "\b", len=3D4, addr1=
=3D14360,
l=3D4, mr=3D0x55555725f700) at qemu/exec.c:3367
#28 0x00005555557fd027 in flatview_write (fv=3D0x7fffe02307f0,
addr=3D4273747992, attrs=3D..., buf=3D0x7ffff7fcb028 "\b", len=3D4) at
qemu/exec.c:3406
#29 0x00005555557fd32c in address_space_write (as=3D0x55555641e640
<address_space_memory>, addr=3D4273747992, attrs=3D..., buf=3D0x7ffff7fcb=
028
"\b", len=3D4) at qemu/exec.c:3496
#30 0x00005555557fd37e in address_space_rw (as=3D0x55555641e640
<address_space_memory>, addr=3D4273747992, attrs=3D..., buf=3D0x7ffff7fcb=
028
"\b", len=3D4, is_write=3Dtrue) at qemu/exec.c:3507
#31 0x0000555555876629 in kvm_cpu_exec (cpu=3D0x55555670e860) at
qemu/accel/kvm/kvm-all.c:2288
#32 0x000055555584c1d8 in qemu_kvm_cpu_thread_fn (arg=3D0x55555670e860) a=
t
qemu/cpus.c:1290
#33 0x0000555555e48991 in qemu_thread_start (args=3D0x5555567328a0) at
qemu/util/qemu-thread-posix.c:502

Note 1: To trigger this I have to build with:

   ./configure --extra-cflags=3D-ggdb --enable-debug --enable-sanitizers

Using different combinations I can not reproduce the crash.

Note 2: We miss some Makefile rules in QEMU with the libslirp split.

Checkouting branches in the slirp/ directory doesn't trigger recompiling
the slirp object, and even if I force the creation of the libslirp.a
archive, the QEMU binaries are not linked again with the refreshed archiv=
e.

