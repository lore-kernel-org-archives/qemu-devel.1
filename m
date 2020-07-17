Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718DFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 13:41:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34E5820734
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 13:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E5820734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwQcK-0007qR-GS
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 09:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jwQbh-0007Op-NU
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 09:40:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49756)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jwQbe-000084-TL
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 09:40:57 -0400
Received: from mail-ua1-f69.google.com ([209.85.222.69])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jwQbc-0006hy-5C
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 13:40:52 +0000
Received: by mail-ua1-f69.google.com with SMTP id o9so1712510uar.22
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 06:40:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Gj50aoMUWKRCBVL8C6Ws3t48A0VcXMkp+0AdQ7VGEhI=;
 b=fns2DHaMZL47fI212hBKYWPhw9pdxI8OmbfbDHvD4RyA2uUkOCFMnFKYbbu8E57/EN
 Myqf6cJ8tqvr51kfN1GxPYvkxJ2EzOS6uM03prIq1mJx+9AM6fB22w8yHCVGJ0YQJ8L/
 HOYMRW/gXuGuK70e05f9VqND5xM3ocjkHx9DJ5SapGZIrXxoreFNJxrbiDQxA8GSidUM
 4OF/QBZ4JHkDkPkXfd/0bFebx1+7uyVXxKjI7Qo77MCTq4LudlWsJiu15HU8FN1TEyNc
 l3Fq1uzdyjutq2q20O84p2sZ5ubiGSfHYOon4TP5zPSko1jvnsjrhCoxw3Vy4wD4249l
 pV8Q==
X-Gm-Message-State: AOAM532t3Cn+R/kBqEu7yKIC3SfP8p4VsYigKwUHMVP12rDmpnSPZ4lN
 6BXoDzniPJ+C/oGvnB1xAhpV2/FNeJ0HKrX1ygUYfgxfvM4QawDwpqWSIZckvavOg478GupjkGA
 xWZqg/Fcp2oXxm5XNRgrPra0p1BG6D4+KZlz4c9sdWgeHiCYA
X-Received: by 2002:a1f:255:: with SMTP id 82mr7428510vkc.39.1594993250637;
 Fri, 17 Jul 2020 06:40:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwygioAni5WAZskhaVyPLaH0owgey+lDoIg2s41Tn2t1FeOxEVrrJSjTxNG7TdgiSgySOnfTytIX+KON7c4YYY=
X-Received: by 2002:a1f:255:: with SMTP id 82mr7428479vkc.39.1594993250251;
 Fri, 17 Jul 2020 06:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAATJJ0JDs78irZYRA7-wBefZhmTFK7SpCecuq79Ub-8n1jfy3A@mail.gmail.com>
 <alpine.LMD.2.03.2007151755360.31652@eik.bme.hu>
 <CAATJJ0L2V5QgPHoJW25HrT1_4_YhZJOLS=jFdCU6+JkHFG_MbA@mail.gmail.com>
 <871rlbwhlp.fsf@linaro.org>
In-Reply-To: <871rlbwhlp.fsf@linaro.org>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Fri, 17 Jul 2020 15:40:24 +0200
Message-ID: <CAATJJ0+v5jPD+Qed8oq4i=pfKt5xXVhUq5kPw8P-KGEUOnb_3g@mail.gmail.com>
Subject: Re: TB Cache size grows out of control with qemu 5.0
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000019cd5405aaa34ed0"
Received-SPF: none client-ip=91.189.89.112;
 envelope-from=christian.ehrhardt@canonical.com; helo=youngberry.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 09:40:52
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000019cd5405aaa34ed0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2020 at 6:27 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

>
> Christian Ehrhardt <christian.ehrhardt@canonical.com> writes:
>
> > On Wed, Jul 15, 2020 at 5:58 PM BALATON Zoltan <balaton@eik.bme.hu>
> wrote:
> >
> >> See commit 47a2def4533a2807e48954abd50b32ecb1aaf29a and the next two
> >> following it.
> >>
> >
> > Thank you Zoltan for pointing out this commit, I agree that this seems
> to be
> > the trigger for the issues I'm seeing. Unfortunately the common CI host
> size
> > is 1-2G. For example on Ubuntu Autopkgtests 1.5G.
> > Those of them running guests do so in 0.5-1G size in TCG mode
> > (as they often can't rely on having KVM available).
> >
> > The 1G TB buffer + 0.5G actual guest size + lack of dynamic downsizing
> > on memory pressure (never existed) makes these systems go OOM-Killing
> > the qemu process.
>
> Ooops. I admit the assumption was that most people running system
> emulation would be doing it on beefier machines.
>
> > The patches indicated that the TB flushes on a full guest boot are a
> > good indicator of the TB size efficiency. From my old checks I had:
> >
> > - Qemu 4.2 512M guest with 32M default overwritten by ram-size/4
> > TB flush count      14, 14, 16
> > - Qemu 5.0 512M guest with 1G default
> > TB flush count      1, 1, 1
> >
> > I agree that ram/4 seems odd, especially on huge guests that is a lot
> > potentially wasted. And most environments have a bit of breathing
> > room 1G is too big in small host systems and the common CI system falls
> > into this category. So I tuned it down to 256M for a test.
> >
> > - Qemu 4.2 512M guest with tb-size 256M
> > TB flush count      5, 5, 5
> > - Qemu 5.0 512M guest with tb-size 256M
> > TB flush count      5, 5, 5
> > - Qemu 5.0 512M guest with 256M default in code
> > TB flush count      5, 5, 5
> >
> > So performance wise the results are as much in-between as you'd think
> from a
> > TB size in between. And the memory consumption which (for me) is the
> actual
> > current issue to fix would be back in line again as expected.
>
> So I'm glad you have the workaround.
>
> >
> > So on one hand I'm suggesting something like:
> > --- a/accel/tcg/translate-all.c
> > +++ b/accel/tcg/translate-all.c
> > @@ -944,7 +944,7 @@ static void page_lock_pair(PageDesc **re
> >   * Users running large scale system emulation may want to tweak their
> >   * runtime setup via the tb-size control on the command line.
> >   */
> > -#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (1 * GiB)
> > +#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (256 * MiB)
>
> The problem we have is any number we pick here is arbitrary. And while
> it did regress your use-case changing it again just pushes a performance
> regression onto someone else.


Thanks for your feedback Alex!

That is true "for you" since 5.0 is released from upstreams POV.
But from the downstreams POV no 5.0 exists for Ubuntu yet and I'd break
many places releasing it like that.
Sadly the performance gain to the other cases will most likely go unnoticed=
.


> The most (*) 64 bit desktop PCs have 16Gb
> of RAM, almost all have more than 8gb. And there is a workaround.
>

Due to our work around virtualization the values representing
"most 64 bit desktop PCs" aren't the only thing that matters :-)

...


> > This is a bit more tricky than it seems as ram_sizes is no more
> > present in that context but it is enough to discuss it.
> > That should serve all cases - small and large - better as a pure
> > static default of 1G or always ram/4?
>
> I'm definitely against re-introducing ram_size into the mix. The
> original commit (a1b18df9a4) that broke this introduced an ordering
> dependency which we don't want to bring back.
>

I agree with that reasoning, but currently without any size dependency
the "arbitrary value" we picked to be 1G is even more fixed than it was
before.
Compared to pre v5.0 for now I can only decide to
a) tune it down -> performance impact for huge guests
b) keep it at 1G -> functional breakage with small hosts

I'd be more amenable to something that took into account host memory and
> limited the default if it was smaller than a threshold. Is there a way
> to probe that that doesn't involve slurping /proc/meminfo?
>

I agree that a host-size dependency might be the better way to go,
yet I have no great cross-platform resilient way to get that.
Maybe we can make it like "if I can get some value consider it,
otherwise use the current default".
That would improve many places already, while keeping the rest at the
current behavior.


> >
> > P.S. I added Alex being the Author of the offending patch and
> Richard/Paolo
> > for being listed in the Maintainers file for TCG.
>
>
>
From Zoltan (unifying the thread a bit):

> I agree that this should be dependent on host memory size not guest
> ram_size but it might be tricky to get that value because different host
> OSes would need different ways.

Well - where it isn't available we will continue to take the default
qemu 5.0 already had. If required on other platforms as well they can add
their way of host memory detection into this as needed.

> Maybe a new qemu_host_mem_size portability
> function will be needed that implements this for different host OSes.
> POSIX may or may not have sysconf _SC_PHYS_PAGES and _SC_AVPHYS_PAGES

We should not try to get into the business of _SC_AVPHYS_PAGES and
try to understand/assume what might be cache or otherwise (re)usable.
Since we only look for some alignment to hosts size _SC_PHYS_PAGES should
be good enough and available in more places than the other options.

> and linux has sysinfo but don't know how reliable these are.

sysconf is slightly more widely available than sysinfo and has enough for
what we need.


I have combined the thoughts above into a patch and it works well in
my tests.

32G Host:
pages 8187304.000000
pagesize 4096.000000
max_default 4191899648
final tb_size 1073741824

(qemu) info jit
Translation buffer state:
gen code size       210425059/1073736659
TB count            368273
TB avg target size  20 max=3D1992 bytes
TB avg host size    330 bytes (expansion ratio: 16.1)
cross page TB count 1656 (0%)
direct jump count   249813 (67%) (2 jumps=3D182112 49%)
TB hash buckets     197613/262144 (75.38% head buckets used)
TB hash occupancy   34.15% avg chain occ. Histogram: [0,10)%|=E2=96=86 =E2=
=96=88
 =E2=96=85=E2=96=81=E2=96=83=E2=96=81=E2=96=81|[90,100]%
TB hash avg chain   1.020 buckets. Histogram: 1|=E2=96=88=E2=96=81=E2=96=81=
|3

Statistics:
TB flush count      1
TB invalidate count 451673
TLB full flushes    0
TLB partial flushes 154819
TLB elided flushes  191627
[TCG profiler not compiled]

=3D> 1G TB size not changed compared to v5.0 - as intended


But on a small 1.5G Host it now works without OOM:

pages 379667.000000
pagesize 4096.000000
max_default 194389504
final tb_size 194389504

(qemu) info jit
Translation buffer state:
gen code size       86179731/194382803
TB count            149995
TB avg target size  20 max=3D1992 bytes
TB avg host size    333 bytes (expansion ratio: 16.5)
cross page TB count 716 (0%)
direct jump count   98854 (65%) (2 jumps=3D74962 49%)
TB hash buckets     58842/65536 (89.79% head buckets used)
TB hash occupancy   51.46% avg chain occ. Histogram: [0,10)%|=E2=96=83 =E2=
=96=87
 =E2=96=88=E2=96=82=E2=96=86=E2=96=81=E2=96=84|[90,100]%
TB hash avg chain   1.091 buckets. Histogram: 1|=E2=96=88=E2=96=81=E2=96=81=
|3

Statistics:
TB flush count      10
TB invalidate count 31733
TLB full flushes    0
TLB partial flushes 180891
TLB elided flushes  244107
[TCG profiler not compiled]

=3D> ~185M which is way more reasonable given the host size

The patch will have a rather large comment in it, I'm not sure if the full
comment is needed, but I wanted to leave a trace what&why is going
on in the code for the next one who comes by.

Submitting as a proper patch to the list in a bit ...

--=20
> Alex Benn=C3=A9e
>


--=20
Christian Ehrhardt
Staff Engineer, Ubuntu Server
Canonical Ltd

--00000000000019cd5405aaa34ed0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 16, 2020 at 6:27 PM Alex =
Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org" target=3D"_blank"=
>alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex"><br>
Christian Ehrhardt &lt;<a href=3D"mailto:christian.ehrhardt@canonical.com" =
target=3D"_blank">christian.ehrhardt@canonical.com</a>&gt; writes:<br>
<br>
&gt; On Wed, Jul 15, 2020 at 5:58 PM BALATON Zoltan &lt;<a href=3D"mailto:b=
alaton@eik.bme.hu" target=3D"_blank">balaton@eik.bme.hu</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; See commit 47a2def4533a2807e48954abd50b32ecb1aaf29a and the next t=
wo<br>
&gt;&gt; following it.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Thank you Zoltan for pointing out this commit, I agree that this seems=
 to be<br>
&gt; the trigger for the issues I&#39;m seeing. Unfortunately the common CI=
 host size<br>
&gt; is 1-2G. For example on Ubuntu Autopkgtests 1.5G.<br>
&gt; Those of them running guests do so in 0.5-1G size in TCG mode<br>
&gt; (as they often can&#39;t rely on having KVM available).<br>
&gt;<br>
&gt; The 1G TB buffer + 0.5G actual guest size + lack of dynamic downsizing=
<br>
&gt; on memory pressure (never existed) makes these systems go OOM-Killing<=
br>
&gt; the qemu process.<br>
<br>
Ooops. I admit the assumption was that most people running system<br>
emulation would be doing it on beefier machines.<br>
<br>
&gt; The patches indicated that the TB flushes on a full guest boot are a<b=
r>
&gt; good indicator of the TB size efficiency. From my old checks I had:<br=
>
&gt;<br>
&gt; - Qemu 4.2 512M guest with 32M default overwritten by ram-size/4<br>
&gt; TB flush count=C2=A0 =C2=A0 =C2=A0 14, 14, 16<br>
&gt; - Qemu 5.0 512M guest with 1G default<br>
&gt; TB flush count=C2=A0 =C2=A0 =C2=A0 1, 1, 1<br>
&gt;<br>
&gt; I agree that ram/4 seems odd, especially on huge guests that is a lot<=
br>
&gt; potentially wasted. And most environments have a bit of breathing<br>
&gt; room 1G is too big in small host systems and the common CI system fall=
s<br>
&gt; into this category. So I tuned it down to 256M for a test.<br>
&gt;<br>
&gt; - Qemu 4.2 512M guest with tb-size 256M<br>
&gt; TB flush count=C2=A0 =C2=A0 =C2=A0 5, 5, 5<br>
&gt; - Qemu 5.0 512M guest with tb-size 256M<br>
&gt; TB flush count=C2=A0 =C2=A0 =C2=A0 5, 5, 5<br>
&gt; - Qemu 5.0 512M guest with 256M default in code<br>
&gt; TB flush count=C2=A0 =C2=A0 =C2=A0 5, 5, 5<br>
&gt;<br>
&gt; So performance wise the results are as much in-between as you&#39;d th=
ink from a<br>
&gt; TB size in between. And the memory consumption which (for me) is the a=
ctual<br>
&gt; current issue to fix would be back in line again as expected.<br>
<br>
So I&#39;m glad you have the workaround. <br>
<br>
&gt;<br>
&gt; So on one hand I&#39;m suggesting something like:<br>
&gt; --- a/accel/tcg/translate-all.c<br>
&gt; +++ b/accel/tcg/translate-all.c<br>
&gt; @@ -944,7 +944,7 @@ static void page_lock_pair(PageDesc **re<br>
&gt;=C2=A0 =C2=A0* Users running large scale system emulation may want to t=
weak their<br>
&gt;=C2=A0 =C2=A0* runtime setup via the tb-size control on the command lin=
e.<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (1 * GiB)<br>
&gt; +#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (256 * MiB)<br>
<br>
The problem we have is any number we pick here is arbitrary. And while<br>
it did regress your use-case changing it again just pushes a performance<br=
>
regression onto someone else.</blockquote><div><br></div><div><div>Thanks f=
or your feedback Alex!</div><div><br></div><div>That is true &quot;for you&=
quot; since 5.0 is released from upstreams POV.</div><div>But from the down=
streams POV no 5.0 exists for Ubuntu yet and I&#39;d break</div><div>many p=
laces releasing it like that.</div><div>Sadly the performance gain to the o=
ther cases will most likely go unnoticed.</div><div></div></div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">The most (*) 64 bit=
 desktop PCs have 16Gb<br>
of RAM, almost all have more than 8gb. And there is a workaround.<br></bloc=
kquote><div><br></div><div>Due to our work around virtualization the values=
 representing</div><div>&quot;most 64 bit desktop PCs&quot; aren&#39;t the =
only thing that matters :-)</div><div><br></div><div>...</div><div>=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; This is a bit mo=
re tricky than it seems as ram_sizes is no more<br>
&gt; present in that context but it is enough to discuss it.<br>
&gt; That should serve all cases - small and large - better as a pure<br>
&gt; static default of 1G or always ram/4?<br>
<br>
I&#39;m definitely against re-introducing ram_size into the mix. The<br>
original commit (a1b18df9a4) that broke this introduced an ordering<br>
dependency which we don&#39;t want to bring back.<br></blockquote><div>=C2=
=A0</div><div>I agree with that reasoning, but currently without any size d=
ependency</div><div>the &quot;arbitrary value&quot; we picked to be 1G is e=
ven more fixed=C2=A0than it was before.</div><div>Compared to pre v5.0 for =
now I can only decide to</div><div>a) tune it down -&gt; performance impact=
 for huge guests</div><div>b) keep it at 1G -&gt; functional breakage with =
small hosts</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
I&#39;d be more amenable to something that took into account host memory an=
d<br>
limited the default if it was smaller than a threshold. Is there a way<br>
to probe that that doesn&#39;t involve slurping /proc/meminfo?<br></blockqu=
ote><div><br></div><div>I agree that a host-size dependency might be the be=
tter way to go,</div><div>yet I have no great cross-platform resilient way =
to get that.</div><div>Maybe we can make it like &quot;if I can get some va=
lue consider it,</div><div>otherwise use the current default&quot;.</div><d=
iv>That would improve many places already, while keeping the rest at the cu=
rrent behavior.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
&gt;<br>
&gt; P.S. I added Alex being the Author of the offending patch and Richard/=
Paolo<br>
&gt; for being listed in the Maintainers file for TCG.<br>
<br>
<br></blockquote><div><br></div><div>From Zoltan (unifying the thread a bit=
):</div><div><br></div><div>&gt; I agree that this should be dependent on h=
ost memory size not guest<br>&gt; ram_size but it might be tricky to get th=
at value because different host<br>&gt; OSes would need different ways.</di=
v><div><br></div><div>Well - where it isn&#39;t available we will continue =
to take the default<br>qemu 5.0 already had. If required on other platforms=
 as well they can add<br>their way of host memory detection into this as ne=
eded.<br></div><div><br></div><div>&gt; Maybe a new qemu_host_mem_size port=
ability<br>&gt; function will be needed that implements this for different =
host OSes.<br>&gt; POSIX may or may not have sysconf _SC_PHYS_PAGES and _SC=
_AVPHYS_PAGES</div><div><br></div><div>We should not try to get into the bu=
siness of _SC_AVPHYS_PAGES and<br>try to understand/assume what might be ca=
che or otherwise (re)usable.<br>Since we only look for some alignment to ho=
sts size _SC_PHYS_PAGES should<br>be good enough and available in more plac=
es than the other options.<br></div><div><br></div><div>&gt; and=C2=A0linux=
 has sysinfo but don&#39;t know how reliable these are.<br></div><div><br><=
/div><div>sysconf is slightly more widely available than sysinfo and has en=
ough for what we need.</div><div><br></div><div><br></div><div>I have combi=
ned the thoughts=C2=A0above into a patch and it works well in</div><div>my =
tests.</div><div><br></div><div>32G Host:<br>pages 8187304.000000<br>pagesi=
ze 4096.000000<br>max_default 4191899648<br>final tb_size 1073741824<br><br=
>(qemu) info jit<br>Translation buffer state:<br>gen code size =C2=A0 =C2=
=A0 =C2=A0 210425059/1073736659<br>TB count =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0368273<br>TB avg target size =C2=A020 max=3D1992 bytes<br>TB avg =
host size =C2=A0 =C2=A0330 bytes (expansion ratio: 16.1)<br>cross page TB c=
ount 1656 (0%)<br>direct jump count =C2=A0 249813 (67%) (2 jumps=3D182112 4=
9%)<br>TB hash buckets =C2=A0 =C2=A0 197613/262144 (75.38% head buckets use=
d)<br>TB hash occupancy =C2=A0 34.15% avg chain occ. Histogram: [0,10)%|=E2=
=96=86 =E2=96=88 =C2=A0=E2=96=85=E2=96=81=E2=96=83=E2=96=81=E2=96=81|[90,10=
0]%<br>TB hash avg chain =C2=A0 1.020 buckets. Histogram: 1|=E2=96=88=E2=96=
=81=E2=96=81|3<br><br>Statistics:<br>TB flush count =C2=A0 =C2=A0 =C2=A01<b=
r>TB invalidate count 451673<br>TLB full flushes =C2=A0 =C2=A00<br>TLB part=
ial flushes 154819<br>TLB elided flushes =C2=A0191627<br>[TCG profiler not =
compiled]<br><br>=3D&gt; 1G TB size not changed compared to v5.0 - as inten=
ded<br><br><br>But on a small 1.5G Host it now works without OOM:<br><br>pa=
ges 379667.000000<br>pagesize 4096.000000<br>max_default 194389504<br>final=
 tb_size 194389504<br><br>(qemu) info jit<br>Translation buffer state:<br>g=
en code size =C2=A0 =C2=A0 =C2=A0 86179731/194382803<br>TB count =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0149995<br>TB avg target size =C2=A020 max=3D=
1992 bytes<br>TB avg host size =C2=A0 =C2=A0333 bytes (expansion ratio: 16.=
5)<br>cross page TB count 716 (0%)<br>direct jump count =C2=A0 98854 (65%) =
(2 jumps=3D74962 49%)<br>TB hash buckets =C2=A0 =C2=A0 58842/65536 (89.79% =
head buckets used)<br>TB hash occupancy =C2=A0 51.46% avg chain occ. Histog=
ram: [0,10)%|=E2=96=83 =E2=96=87 =C2=A0=E2=96=88=E2=96=82=E2=96=86=E2=96=81=
=E2=96=84|[90,100]%<br>TB hash avg chain =C2=A0 1.091 buckets. Histogram: 1=
|=E2=96=88=E2=96=81=E2=96=81|3<br><br>Statistics:<br>TB flush count =C2=A0 =
=C2=A0 =C2=A010<br>TB invalidate count 31733<br>TLB full flushes =C2=A0 =C2=
=A00<br>TLB partial flushes 180891<br>TLB elided flushes =C2=A0244107<br>[T=
CG profiler not compiled]<br><br>=3D&gt; ~185M which is way more reasonable=
 given the host size<br></div><div><br></div><div>The patch will have a rat=
her large comment in it, I&#39;m not sure if the full</div><div>comment is =
needed, but I wanted to leave a trace what&amp;why is going</div><div>on in=
 the code for the next one who comes by.</div><div><br></div><div>Submittin=
g as a proper patch to the list in a bit ...</div><div><br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
-- <br>
Alex Benn=C3=A9e<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
>Christian Ehrhardt<br>Staff Engineer, Ubuntu Server<br>Canonical Ltd</div>=
</div>

--00000000000019cd5405aaa34ed0--

