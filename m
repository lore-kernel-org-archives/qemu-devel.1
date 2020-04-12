Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC0EC2BA2B
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 12:05:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34209206E9
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 12:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34209206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNbMd-0007uU-8q
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 08:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51600)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jNbKb-0006gY-FU
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 08:03:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jNbKZ-0000hU-Dx
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 08:03:21 -0400
Received: from 7.mo179.mail-out.ovh.net ([46.105.61.94]:47226)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jNbKZ-0000gi-0r
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 08:03:19 -0400
Received: from player687.ha.ovh.net (unknown [10.108.54.97])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 72991160B3F
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2020 14:03:15 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player687.ha.ovh.net (Postfix) with ESMTPSA id 9CC5A114BACC1;
 Sun, 12 Apr 2020 12:03:01 +0000 (UTC)
Subject: Re: Boot flakiness with QEMU 3.1.0 and Clang built kernels
To: Nicholas Piggin <npiggin@gmail.com>,
 Nathan Chancellor <natechancellor@gmail.com>
References: <20200410205932.GA880@ubuntu-s3-xlarge-x86>
 <1586564375.zt8lm9finh.astroid@bobo.none>
 <20200411005354.GA24145@ubuntu-s3-xlarge-x86>
 <1586597161.xyshvdbjo6.astroid@bobo.none>
 <1586612535.6kk4az03np.astroid@bobo.none>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <d405d8be-93a5-e68c-9ebe-ef42b0f5e87a@kaod.org>
Date: Sun, 12 Apr 2020 14:03:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1586612535.6kk4az03np.astroid@bobo.none>
Content-Type: multipart/mixed; boundary="------------B729630F00F9E16D7736EACA"
Content-Language: en-US
X-Ovh-Tracer-Id: 252764531685428071
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrvdejgdegkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgesmhdtreertdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheikeejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.61.94
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
Cc: Michael Neuling <mikey@neuling.org>, qemu-devel@nongnu.org,
 clang-built-linux@googlegroups.com, qemu-ppc@nongnu.org,
 Anton Blanchard <anton@ozlabs.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------B729630F00F9E16D7736EACA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 4/11/20 3:57 PM, Nicholas Piggin wrote:
> Nicholas Piggin's on April 11, 2020 7:32 pm:
>> Nathan Chancellor's on April 11, 2020 10:53 am:
>>> The tt.config values are needed to reproduce but I did not verify that
>>> ONLY tt.config was needed. Other than that, no, we are just building
>>> either pseries_defconfig or powernv_defconfig with those configs and
>>> letting it boot up with a simple initramfs, which prints the version
>>> string then shuts the machine down.
>>>
>>> Let me know if you need any more information, cheers!
>>
>> Okay I can reproduce it. Sometimes it eventually recovers after a long
>> pause, and some keyboard input often helps it along. So that seems like 
>> it might be a lost interrupt.
>>
>> POWER8 vs POWER9 might just be a timing thing if P9 is still hanging
>> sometimes. I wasn't able to reproduce it with defconfig+tt.config, I
>> needed your other config with various other debug options.
>>
>> Thanks for the very good report. I'll let you know what I find.
> 
> It looks like a qemu bug. Booting with '-d int' shows the decrementer 
> simply stops firing at the point of the hang, even though MSR[EE]=1 and 
> the DEC register is wrapping. Linux appears to be doing the right thing 
> as far as I can tell (not losing interrupts).
> 
> This qemu patch fixes the boot hang for me. I don't know that qemu 
> really has the right idea of "context synchronizing" as defined in the
> powerpc architecture -- mtmsrd L=1 is not context synchronizing but that
> does not mean it can avoid looking at exceptions until the next such
> event. It looks like the decrementer exception goes high but the
> execution of mtmsrd L=1 is ignoring it.
> 
> Prior to the Linux patch 3282a3da25b you bisected to, interrupt replay
> code would return with an 'rfi' instruction as part of interrupt return,
> which probably helped to get things moving along a bit. However it would
> not be foolproof, and Cedric did say he encountered some mysterious
> lockups under load with qemu powernv before that patch was merged, so
> maybe it's the same issue?

Nope :/ but this is a fix for an important problem reported by Anton in 
November. Attached is the test case.  

Thanks,

C. 


 

--------------B729630F00F9E16D7736EACA
Content-Type: text/plain; charset=UTF-8;
 name="test.S"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="test.S"

LyoKCk1pa2V5IGFuZCBJIG5vdGljZWQgdGhhdCB0aGUgZGVjcmVtZW50ZXIgaXNuJ3QgZmly
aW5nIHdoZW4KaXQgc2hvdWxkLiBJZiBhIGRlY3JlbWVudGVyIGlzIHBlbmRpbmcgYW5kIGFu
IG10bXNyZChNU1JfRUUpIGlzCmV4ZWN1dGVkIHRoZW4gd2Ugc2hvdWxkIHRha2UgdGhlIGRl
Y3JlbWVudGVyIGV4Y2VwdGlvbi4gRnJvbSB0aGUgUFBDIEFTOgoKICBJZiBNU1IgRUUgPSAw
IGFuZCBhbiBFeHRlcm5hbCwgRGVjcmVtZW50ZXIsIG9yIFBlci0KICBmb3JtYW5jZSBNb25p
dG9yIGV4Y2VwdGlvbiBpcyBwZW5kaW5nLCBleGVjdXRpbmcKICBhbiBtdG1zcmQgaW5zdHJ1
Y3Rpb24gdGhhdCBzZXRzIE1TUiBFRSB0byAxIHdpbGwKICBjYXVzZSB0aGUgaW50ZXJydXB0
IHRvIG9jY3VyIGJlZm9yZSB0aGUgbmV4dCBpbnN0cnVjLQogIHRpb24gaXMgZXhlY3V0ZWQs
IGlmIG5vIGhpZ2hlciBwcmlvcml0eSBleGNlcHRpb24KICBleGlzdHMKCkEgdGVzdCBjYXNl
IGlzIGJlbG93LiByMzEgaXMgaW5jcmVtZW50ZWQgZm9yIGV2ZXJ5IGRlY3JlbWVudGVyCmV4
Y2VwdGlvbi4KCnBvd2VycGM2NGxlLWxpbnV4LWdjYyAtYyB0ZXN0LlMKcG93ZXJwYzY0bGUt
bGludXgtbGQgLVR0ZXh0PTB4MCAtbyB0ZXN0LmVsZiB0ZXN0Lm8KcG93ZXJwYzY0bGUtbGlu
dXgtb2JqY29weSAtTyBiaW5hcnkgdGVzdC5lbGYgdGVzdC5iaW4KCnFlbXUtc3lzdGVtLXBw
YzY0IC1NIHBvd2VybnYgLWNwdSBQT1dFUjkgLW5vZ3JhcGhpYyAtYmlvcyB0ZXN0LmJpbgoK
ImluZm8gcmVnaXN0ZXJzIiBzaG93cyBpdCBsb29waW5nIGluIHRoZSBsb3dlciBsb29wLCBp
ZSB0aGUKZGVjcmVtZW50ZXIgZXhjZXB0aW9uIHdhcyBuZXZlciB0YWtlbi4KCnIzMSBuZXZl
ciBtb3Zlcy4gSWYgSSBidWlsZCB3aXRoOgoKcG93ZXJwYzY0bGUtbGludXgtZ2NjIC1ERklY
X0JST0tFTiAtYyB0ZXN0LlMKCkkgc2VlIHIzMSBtb3ZlLgoKKi8KCiNpbmNsdWRlIDxwcGMt
YXNtLmg+CgovKiBMb2FkIGFuIGltbWVkaWF0ZSA2NC1iaXQgdmFsdWUgaW50byBhIHJlZ2lz
dGVyICovCiNkZWZpbmUgTE9BRF9JTU02NChyLCBlKQkJCVwKCWxpcwlyLChlKUBoaWdoZXN0
OwkJCVwKCW9yaQlyLHIsKGUpQGhpZ2hlcjsJCQlcCglybGRpY3IJcixyLCAzMiwgMzE7CQkJ
XAoJb3JpcwlyLHIsIChlKUBoOwkJCVwKCW9yaQlyLHIsIChlKUBsOwoKI2RlZmluZSBGSVhV
UF9FTkRJQU4JCQkJCQkgICBcCgl0ZGkgICAwLDAsMHg0ODsJICAvKiBSZXZlcnNlIGVuZGlh
biBvZiBiIC4gKyA4CQkqLyBcCgliICAgICAxOTFmOwkgIC8qIFNraXAgdHJhbXBvbGluZSBp
ZiBlbmRpYW4gaXMgZ29vZAkqLyBcCgkubG9uZyAweGE2MDA2MDdkOyAvKiBtZm1zciByMTEJ
CQkJKi8gXAoJLmxvbmcgMHgwMTAwNmI2OTsgLyogeG9yaSByMTEscjExLDEJCQkqLyBcCgku
bG9uZyAweDA1MDA5ZjQyOyAvKiBiY2wgMjAsMzEsJCs0CQkJKi8gXAoJLmxvbmcgMHhhNjAy
NDg3ZDsgLyogbWZsciByMTAJCQkJKi8gXAoJLmxvbmcgMHgxNDAwNGEzOTsgLyogYWRkaSBy
MTAscjEwLDIwCQkJKi8gXAoJLmxvbmcgMHhhNjRiNWE3ZDsgLyogbXRoc3JyMCByMTAJCQkq
LyBcCgkubG9uZyAweGE2NGI3YjdkOyAvKiBtdGhzcnIxIHIxMQkJCSovIFwKCS5sb25nIDB4
MjQwMjAwNGM7IC8qIGhyZmlkCQkJCSovIFwKMTkxOgoKCS49IDB4MAouZ2xvYmwgX3N0YXJ0
Cl9zdGFydDoKCWIJMWYKCgkuPSAweDEwCglGSVhVUF9FTkRJQU4KCWIJMWYKCgkuPSAweDEw
MAoxOgoJRklYVVBfRU5ESUFOCgliCV9faW5pdGlhbGl6ZQoKI2RlZmluZSBFWENFUFRJT04o
bnIpCQlcCgkuPSBucgkJCTtcCgliCS4KCgkvKiBNb3JlIGV4Y2VwdGlvbiBzdHVicyAqLwoJ
RVhDRVBUSU9OKDB4MzAwKQoJRVhDRVBUSU9OKDB4MzgwKQoJRVhDRVBUSU9OKDB4NDAwKQoJ
RVhDRVBUSU9OKDB4NDgwKQoJRVhDRVBUSU9OKDB4NTAwKQoJRVhDRVBUSU9OKDB4NjAwKQoJ
RVhDRVBUSU9OKDB4NzAwKQoJRVhDRVBUSU9OKDB4ODAwKQoKCS49IDB4OTAwCglMT0FEX0lN
TTY0KHIwLCAweDEwMDAwMDApCgltdGRlYwlyMAoJYWRkaQlyMzEscjMxLDEKCXJmaWQKCglF
WENFUFRJT04oMHg5ODApCglFWENFUFRJT04oMHhhMDApCglFWENFUFRJT04oMHhiMDApCglF
WENFUFRJT04oMHhjMDApCglFWENFUFRJT04oMHhkMDApCglFWENFUFRJT04oMHhlMDApCglF
WENFUFRJT04oMHhlMjApCglFWENFUFRJT04oMHhlNDApCglFWENFUFRJT04oMHhlNjApCglF
WENFUFRJT04oMHhlODApCglFWENFUFRJT04oMHhmMDApCglFWENFUFRJT04oMHhmMjApCglF
WENFUFRJT04oMHhmNDApCglFWENFUFRJT04oMHhmNjApCglFWENFUFRJT04oMHhmODApCglF
WENFUFRJT04oMHgxMDAwKQoJRVhDRVBUSU9OKDB4MTEwMCkKCUVYQ0VQVElPTigweDEyMDAp
CglFWENFUFRJT04oMHgxMzAwKQoJRVhDRVBUSU9OKDB4MTQwMCkKCUVYQ0VQVElPTigweDE1
MDApCglFWENFUFRJT04oMHgxNjAwKQoKX19pbml0aWFsaXplOgoJLyogU0YsIEhWLCBFRSwg
UkksIExFICovCglMT0FEX0lNTTY0KHIwLCAweDkwMDAwMDAwMDAwMDgwMDMpCgltdG1zcmQJ
cjAKCQoJLyogSElEMDogSElMRSAqLwoJTE9BRF9JTU02NChyMCwgMHg4MDAwMDAwMDAwMDAw
MDApCgltdHNwcgkweDNmMCxyMAoKCUxPQURfSU1NNjQocjAsIDB4MTAwMDAwMCkKCW10ZGVj
IHIwCgoxOglMT0FEX0lNTTY0KHIzMCwweDgwMDApCgltdG1zcmQJcjMwLDEKCgkvKiBXZSBz
aG91bGQgdGFrZSB0aGUgZGVjcmVtZW50ZXIgaGVyZSAqLwojaWZkZWYgRklYX0JST0tFTgoJ
TE9BRF9JTU02NChyMjksMHgxMDAwMDAwMDApCgltdGN0cglyMjkKMjoJYmRuegkyYgojZW5k
aWYKCglsaQlyMzAsMHgwCgltdG1zcmQJcjMwLDEKCWIJMWIK
--------------B729630F00F9E16D7736EACA--

