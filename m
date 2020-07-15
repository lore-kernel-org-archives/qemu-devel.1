Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC7FC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:31:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1502F205CB
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1502F205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jviRs-0001wk-A3
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 10:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jviQe-0000u9-9Y
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 10:30:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34862)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jviQa-0003zE-Vv
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 10:30:36 -0400
Received: from mail-ua1-f71.google.com ([209.85.222.71])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jviQW-0000d9-BK
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 14:30:28 +0000
Received: by mail-ua1-f71.google.com with SMTP id g17so503184uae.15
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 07:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=7/UfNOyRUveT5K6jbfCn5M95GAxASYGN2xrsvFK4esA=;
 b=BK4IO6M/1NiULmEYTsBXvf9cgF5g/5QuQYG3s4gz62KLAgsMNjj8SA1ucUlDDi70u7
 TkMoi68fXTicBapTqE4PIrkVTM1gmdz4NeAusQTKOKyocIWJbhU/pOOK48EhUALe1hH/
 InnnSZxlIqX7L8G9OTMS7vWyHCYGiQjBjf+H2jnRt0Pbc0lCgHXiOa8XOK4+1onLVeJr
 HoOiqfqOUcU2dUV8q3D5yuMwY7DJn5bU1hi2JJ0g6tFTlinxVq++wloWg8ElKtq+hgG8
 1mqHjcRyGLVxhhlOnBifdGjOwyeVJchy4P/0CelapYZVzpLt+Yv/8DHfwORZTAWxhkbp
 u2YQ==
X-Gm-Message-State: AOAM532LklTDq0B7b3Nysu6q4unhSfjGsH2mWq5QAbV6L2FxJforOYO+
 Ka1w34NPUTtxr+46oKXqv7xn/VrdfModQf8iVG1Eo19favCntnEK8k3CKdOTvqNP1H+f4nb/EUQ
 nolftfidHUpmyQKj6yACmscmgvqMkbIrckFUMzH9YHlKP7Nbl
X-Received: by 2002:a67:330e:: with SMTP id z14mr6892811vsz.94.1594823427104; 
 Wed, 15 Jul 2020 07:30:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwf9y5l170qYxQmHZp+iPcVy11KG0Aa0HK3eSge4VegwP4LOCPBW6W69cfKjucRjGRGT+4eM6hmjnZnV+a0Lag=
X-Received: by 2002:a67:330e:: with SMTP id z14mr6892780vsz.94.1594823426622; 
 Wed, 15 Jul 2020 07:30:26 -0700 (PDT)
MIME-Version: 1.0
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Wed, 15 Jul 2020 16:29:59 +0200
Message-ID: <CAATJJ0JDs78irZYRA7-wBefZhmTFK7SpCecuq79Ub-8n1jfy3A@mail.gmail.com>
Subject: TB Cache size grows out of control with qemu 5.0
To: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000d2dc4205aa7bc37f"
Received-SPF: none client-ip=91.189.89.112;
 envelope-from=christian.ehrhardt@canonical.com; helo=youngberry.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 10:30:28
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

--000000000000d2dc4205aa7bc37f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
Since qemu 5.0 I found that Ubuntu Test environments crashed often.
After a while I found that all affected tests run qemu TCG and
they get into OOM conditions that kills the qemu process.

Steps to reproduce:
Run TCG on a guest image until boot settles:
  $ wget
http://cloud-images.ubuntu.com/daily/server/groovy/20200714/groovy-server-c=
loudimg-amd64.img
  $ qemu-system-x86_64 -name guest=3Dgroovy-testguest,debug-threads=3Don
-machine pc-q35-focal,accel=3Dtcg,usb=3Doff,dump-guest-core=3Doff -cpu qemu=
64 -m
512 -overcommit mem-lock=3Doff -smp 1,sockets=3D1,cores=3D1,threads=3D1 -hd=
a
groovy-server-cloudimg-amd64.img -nographic -serial file:/tmp/serial.debug
I usually wait until I see no faults anymore in pidstat (indicates bootup i=
s
complete). Also at that point the worker threads vanish or at least reduce
significantly.
Then I checked RSS sizes:
  $ pidstat -p $(pgrep -f 'name guest=3Dgroovy-testguest') -T ALL -rt 5

To know the expected deviations I ran it a few times with old/new version

       qemu 4.2           qemu 5.0
    VSZ     RSS        VSZ     RSS
1735828  642172    2322668 1641532
1424596  602368    2374068 1628788
1570060  611372    2789648 1676748
1556696  611240    2981112 1658196
1388844  649696    2443716 1636896
1597788  644584    2989336 1635516

That is ~+160%

I was wondering if that might be the new toolchain or due to features
instead of TCG (even though all non TCG tests showed no issue).
I ran the same with -enable-kvm which shows no difference worth to report:

accel=3Dkvm Old qemu:   accel=3Dkvm New qemu:
    VSZ     RSS           VSZ     RSS
1844232  489224       1195880  447696
1068784  448324       1330036  484464
1583020  448708       1380408  468588
1247244  493980       1244148  493188
1702912  483444       1247672  454444
1287980  448480       1983548  501184

So it seems to come down to "4.2 TCG vs 5.0 TCG"
Therefore I have spun up a 4.2 and a 5.0 qemu with TCG showing this ~+160%
increased memory consumption.
Using smem I then check where the consumption was per mapping:

# smem --reverse --mappings --abbreviate --processfilter=3Dqemu-system-x86_=
64
| head -n 10
                           qemu 4.2          qemu 5.0
Map                 AVGPSS      PSS   AVGPSS      PSS
<anonymous>         289.5M   579.0M   811.5M     1.6G
qemu-system-x86_64    9.1M     9.1M     9.2M     9.2M
[heap]                2.8M     5.6M     3.4M     6.8M
/usr/bin/python3.8    1.8M     1.8M     1.8M     1.8M
/libepoxy.so.0.     448.0K   448.0K   448.0K   448.0K
/libcrypto.so.1     296.0K   296.0K   275.0K   275.0K
/libgnutls.so.3     234.0K   234.0K   230.0K   230.0K
/libasound.so.2     208.0K   208.0K   208.0K   208.0K
/libssl.so.1.1      180.0K   180.0K    92.0K   184.0K

So all the increase is in anon memory of qemu.

Since it is TCG I ran `info jit` in the Monitor

qemu 4.2:
(qemu) info jit
Translation buffer state:
gen code size       99.781.715/134.212.563
TB count            183622
TB avg target size  18 max=3D1992 bytes
TB avg host size    303 bytes (expansion ratio: 16.4)
cross page TB count 797 (0%)
direct jump count   127941 (69%) (2 jumps=3D91451 49%)
TB hash buckets     98697/131072 (75.30% head buckets used)
TB hash occupancy   34.04% avg chain occ. Histogram: [0,10)%|=E2=96=86 =E2=
=96=88
 =E2=96=85=E2=96=81=E2=96=83=E2=96=81=E2=96=81|[90,100]%
TB hash avg chain   1.020 buckets. Histogram: 1|=E2=96=88=E2=96=81=E2=96=81=
|3

Statistics:
TB flush count      14
TB invalidate count 92226
TLB full flushes    1
TLB partial flushes 175405
TLB elided flushes  233747
[TCG profiler not compiled]

qemu 5.0:
(qemu) info jit
Translation buffer state:
gen code size       259.896.403/1.073.736.659
TB count            456365
TB avg target size  20 max=3D1992 bytes
TB avg host size    328 bytes (expansion ratio: 16.1)
cross page TB count 2020 (0%)
direct jump count   309815 (67%) (2 jumps=3D227122 49%)
TB hash buckets     216220/262144 (82.48% head buckets used)
TB hash occupancy   41.36% avg chain occ. Histogram: [0,10)%|=E2=96=85 =E2=
=96=88
 =E2=96=87=E2=96=81=E2=96=84=E2=96=81=E2=96=82|[90,100]%
TB hash avg chain   1.039 buckets. Histogram: 1|=E2=96=88=E2=96=81=E2=96=81=
|3

Statistics:
TB flush count      1
TB invalidate count 463653
TLB full flushes    0
TLB partial flushes 178464
TLB elided flushes  242382
[TCG profiler not compiled]

Well I see the numbers increase, but this isn't my home turf anymore.

The one related tunabel I know is -tb-size I ran both versions with
  -tb-size 150
And the result gave me two similarly working qemu processes.
RSS
qemu 4.2: 628072 635528
qemu 5.0: 655628 634952

Seems to be "good again" with that tunable set.

It seems the TB default sizing, self size reduction or something like
it cache has changed. On a system with ~1.5G for example (which matches our
testbeds) I'd expect it to back down a bit before being OOM Killed consumin=
g
almost 100% of the memory.

My next step is to build qemu from source without an Ubuntu downstream
delta.
That should help to further track it down and also provide some results of
the soon to be released 5.1. That will probably take until tomorrow,
I'll report here again then.

I searched the mailing list and the web for this behavior, but either I use
the wrong keywords or it wasn't reported/discussed yet.
Nor does [1] list anything that sounds related
But if this already rings a bell for someone please let me know.
Thanks in advance!

[1]: https://wiki.qemu.org/ChangeLog/5.0#TCG

--=20
Christian Ehrhardt
Staff Engineer, Ubuntu Server
Canonical Ltd

--000000000000d2dc4205aa7bc37f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br>Since qemu 5.0 I found that Ubuntu Test environment=
s crashed often.<br>After a while I found that all affected tests run qemu =
TCG and<br>they get into OOM conditions that kills the qemu process.<br><br=
>Steps to reproduce:<br>Run TCG on a guest image until boot settles:<br>=C2=
=A0 $ wget <a href=3D"http://cloud-images.ubuntu.com/daily/server/groovy/20=
200714/groovy-server-cloudimg-amd64.img">http://cloud-images.ubuntu.com/dai=
ly/server/groovy/20200714/groovy-server-cloudimg-amd64.img</a><br>=C2=A0 $ =
qemu-system-x86_64 -name guest=3Dgroovy-testguest,debug-threads=3Don -machi=
ne pc-q35-focal,accel=3Dtcg,usb=3Doff,dump-guest-core=3Doff -cpu qemu64 -m =
512 -overcommit mem-lock=3Doff -smp 1,sockets=3D1,cores=3D1,threads=3D1 -hd=
a groovy-server-cloudimg-amd64.img -nographic -serial file:/tmp/serial.debu=
g<br>I usually wait until I see no faults anymore in pidstat (indicates boo=
tup is<br>complete). Also at that point the worker threads vanish or at lea=
st reduce<br>significantly.<br>Then I checked RSS sizes:<br>=C2=A0 $ pidsta=
t -p $(pgrep -f &#39;name guest=3Dgroovy-testguest&#39;) -T ALL -rt 5<br><b=
r>To know the expected deviations I ran it a few times with old/new version=
<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu 4.2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 qemu 5.0<br>=C2=A0 =C2=A0 VSZ =C2=A0 =C2=A0 RSS =C2=A0 =C2=A0 =C2=A0 =
=C2=A0VSZ =C2=A0 =C2=A0 RSS<br>1735828 =C2=A0642172 =C2=A0 =C2=A02322668 16=
41532<br>1424596 =C2=A0602368 =C2=A0 =C2=A02374068 1628788<br>1570060 =C2=
=A0611372 =C2=A0 =C2=A02789648 1676748<br>1556696 =C2=A0611240 =C2=A0 =C2=
=A02981112 1658196<br>1388844 =C2=A0649696 =C2=A0 =C2=A02443716 1636896<br>=
1597788 =C2=A0644584 =C2=A0 =C2=A02989336 1635516<br><br>That is ~+160%<br>=
<br>I was wondering if that might be the new toolchain or due to features<b=
r>instead of TCG (even though all non TCG tests showed no issue).<br>I ran =
the same with -enable-kvm which shows no difference worth to report:<br><br=
>accel=3Dkvm Old qemu: =C2=A0 accel=3Dkvm New qemu:<br>=C2=A0 =C2=A0 VSZ =
=C2=A0 =C2=A0 RSS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VSZ =C2=A0 =C2=A0 RSS<=
br>1844232 =C2=A0489224 =C2=A0 =C2=A0 =C2=A0 1195880 =C2=A0447696<br>106878=
4 =C2=A0448324 =C2=A0 =C2=A0 =C2=A0 1330036 =C2=A0484464<br>1583020 =C2=A04=
48708 =C2=A0 =C2=A0 =C2=A0 1380408 =C2=A0468588<br>1247244 =C2=A0493980 =C2=
=A0 =C2=A0 =C2=A0 1244148 =C2=A0493188<br>1702912 =C2=A0483444 =C2=A0 =C2=
=A0 =C2=A0 1247672 =C2=A0454444<br>1287980 =C2=A0448480 =C2=A0 =C2=A0 =C2=
=A0 1983548 =C2=A0501184<br><br>So it seems to come down to &quot;4.2 TCG v=
s 5.0 TCG&quot;<br>Therefore I have spun up a 4.2 and a 5.0 qemu with TCG s=
howing this ~+160%<br>increased memory consumption.<br>Using smem I then ch=
eck where the consumption was per mapping:<br><br># smem --reverse --mappin=
gs --abbreviate --processfilter=3Dqemu-system-x86_64 | head -n 10<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0qemu 4.2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu 5.0<br>Map=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AVGPSS =C2=A0 =C2=
=A0 =C2=A0PSS =C2=A0 AVGPSS =C2=A0 =C2=A0 =C2=A0PSS<br>&lt;anonymous&gt; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 289.5M =C2=A0 579.0M =C2=A0 811.5M =C2=A0 =C2=
=A0 1.6G<br>qemu-system-x86_64 =C2=A0 =C2=A09.1M =C2=A0 =C2=A0 9.1M =C2=A0 =
=C2=A0 9.2M =C2=A0 =C2=A0 9.2M<br>[heap] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A02.8M =C2=A0 =C2=A0 5.6M =C2=A0 =C2=A0 3.4M =C2=A0 =C2=
=A0 6.8M<br>/usr/bin/python3.8 =C2=A0 =C2=A01.8M =C2=A0 =C2=A0 1.8M =C2=A0 =
=C2=A0 1.8M =C2=A0 =C2=A0 1.8M<br>/libepoxy.so.0. =C2=A0 =C2=A0 448.0K =C2=
=A0 448.0K =C2=A0 448.0K =C2=A0 448.0K<br>/libcrypto.so.1 =C2=A0 =C2=A0 296=
.0K =C2=A0 296.0K =C2=A0 275.0K =C2=A0 275.0K<br>/libgnutls.so.3 =C2=A0 =C2=
=A0 234.0K =C2=A0 234.0K =C2=A0 230.0K =C2=A0 230.0K<br>/libasound.so.2 =C2=
=A0 =C2=A0 208.0K =C2=A0 208.0K =C2=A0 208.0K =C2=A0 208.0K<br>/libssl.so.1=
.1 =C2=A0 =C2=A0 =C2=A0180.0K =C2=A0 180.0K =C2=A0 =C2=A092.0K =C2=A0 184.0=
K<br><br>So all the increase is in anon memory of qemu.<br><br>Since it is =
TCG I ran `info jit` in the Monitor<br><br>qemu 4.2:<br>(qemu) info jit<br>=
Translation buffer state:<br>gen code size =C2=A0 =C2=A0 =C2=A0 99.781.715/=
134.212.563<br>TB count =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0183622<br>=
TB avg target size =C2=A018 max=3D1992 bytes<br>TB avg host size =C2=A0 =C2=
=A0303 bytes (expansion ratio: 16.4)<br>cross page TB count 797 (0%)<br>dir=
ect jump count =C2=A0 127941 (69%) (2 jumps=3D91451 49%)<br>TB hash buckets=
 =C2=A0 =C2=A0 98697/131072 (75.30% head buckets used)<br>TB hash occupancy=
 =C2=A0 34.04% avg chain occ. Histogram: [0,10)%|=E2=96=86 =E2=96=88 =C2=A0=
=E2=96=85=E2=96=81=E2=96=83=E2=96=81=E2=96=81|[90,100]%<br>TB hash avg chai=
n =C2=A0 1.020 buckets. Histogram: 1|=E2=96=88=E2=96=81=E2=96=81|3<br><br>S=
tatistics:<br>TB flush count =C2=A0 =C2=A0 =C2=A014<br>TB invalidate count =
92226<br>TLB full flushes =C2=A0 =C2=A01<br>TLB partial flushes 175405<br>T=
LB elided flushes =C2=A0233747<br>[TCG profiler not compiled]<br><br>qemu 5=
.0:<br>(qemu) info jit<br>Translation buffer state:<br>gen code size =C2=A0=
 =C2=A0 =C2=A0 259.896.403/1.073.736.659<br>TB count =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0456365<br>TB avg target size =C2=A020 max=3D1992 bytes<=
br>TB avg host size =C2=A0 =C2=A0328 bytes (expansion ratio: 16.1)<br>cross=
 page TB count 2020 (0%)<br>direct jump count =C2=A0 309815 (67%) (2 jumps=
=3D227122 49%)<br>TB hash buckets =C2=A0 =C2=A0 216220/262144 (82.48% head =
buckets used)<br>TB hash occupancy =C2=A0 41.36% avg chain occ. Histogram: =
[0,10)%|=E2=96=85 =E2=96=88 =C2=A0=E2=96=87=E2=96=81=E2=96=84=E2=96=81=E2=
=96=82|[90,100]%<br>TB hash avg chain =C2=A0 1.039 buckets. Histogram: 1|=
=E2=96=88=E2=96=81=E2=96=81|3<br><br>Statistics:<br>TB flush count =C2=A0 =
=C2=A0 =C2=A01<br>TB invalidate count 463653<br>TLB full flushes =C2=A0 =C2=
=A00<br>TLB partial flushes 178464<br>TLB elided flushes =C2=A0242382<br>[T=
CG profiler not compiled]<br><br>Well I see the numbers increase, but this =
isn&#39;t my home turf anymore.<br><br>The one related tunabel I know is -t=
b-size I ran both versions with<br>=C2=A0 -tb-size 150<br>And the result ga=
ve me two similarly working qemu processes.<br>RSS<br>qemu 4.2: 628072 6355=
28<br>qemu 5.0: 655628 634952<br><br>Seems to be &quot;good again&quot; wit=
h that tunable set.<br><br>It seems the TB default sizing, self size reduct=
ion or something like<br>it cache has changed. On a system with ~1.5G for e=
xample (which matches our<br>testbeds) I&#39;d expect it to back down a bit=
 before being OOM Killed consuming<br>almost 100% of the memory.<br><br>My =
next step is to build qemu from source without an Ubuntu downstream delta.<=
br>That should help to further track it down and also provide some results =
of<br>the soon to be released 5.1. That will probably take until tomorrow,<=
br>I&#39;ll report here again then.<br><br>I searched the mailing list and =
the web for this behavior, but either I use<br>the wrong keywords or it was=
n&#39;t reported/discussed yet.<br>Nor does [1] list anything that sounds r=
elated<br>But if this already rings a bell for someone please let me know.<=
br>Thanks in advance!<br><br>[1]: <a href=3D"https://wiki.qemu.org/ChangeLo=
g/5.0#TCG">https://wiki.qemu.org/ChangeLog/5.0#TCG</a><br><div><br></div>--=
 <br><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_sig=
nature">Christian Ehrhardt<br>Staff Engineer, Ubuntu Server<br>Canonical Lt=
d</div></div>

--000000000000d2dc4205aa7bc37f--

