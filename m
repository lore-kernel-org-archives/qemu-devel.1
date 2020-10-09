Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B7BC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 02:23:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDF4922251
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 02:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJcdaYnS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF4922251
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQi4P-0007KH-R1
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 22:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1kQi32-0006im-Ub; Thu, 08 Oct 2020 22:22:26 -0400
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e]:38100)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1kQi30-0001EH-Pp; Thu, 08 Oct 2020 22:22:20 -0400
Received: by mail-io1-xd2e.google.com with SMTP id y20so4432058iod.5;
 Thu, 08 Oct 2020 19:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=B+IhlPNG0WnJ8C/eyKlGq3A2olcxgXB5Ce9kq09pSOQ=;
 b=QJcdaYnSyXj+86/khBGGiwbRcm2WsSEe2sfBxl+UGAxLbbYzJz1ZZc4TmByR07Kekp
 u1RHcI3TKVKC8eYPtcJKNCUTuaun+ATLLUMSGghlXOkO5UaOz8e7S8uGiXIn7uaKJaWn
 HI3p34bZgleInU0uVyiv7CpX0I43w5JOlUc3tCEDDc2pDFoFJKVQvY09X4lUdglaRqd6
 +53zEIaG68Wfak9M0TNpGqVNyh2AqiWCWo2HFGZexi04BlJbgvgzEZAyzpx4PjgsAzAt
 nz7mq59Dc/NWOZNUUHMEwzITgPWtP2gqGn7ZIkghxUdIr3dapzjJUZiVUYtcwS18NO+/
 wz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=B+IhlPNG0WnJ8C/eyKlGq3A2olcxgXB5Ce9kq09pSOQ=;
 b=SKrY591KbSLJBR6upSoYVSfxDBGH39/fDBP4yX3nz2ULnNkHv8XXAmHvh5uG0H6FE6
 XB7hrJD+B/wJntwpZEy5ys2Un3ROXZ5rSBnzP7gAksM+ifO2ZZKyXJlHaCyJzw6NCgYH
 G9phaGbNnfwVCsOqdueJ75nXROmZB/D7T2JXDqzc57bXBx2WVdgfaziU8idijhXePdFW
 0hZekvAUNdtNoE4jY2h5TVFysZQrAgKisg55oAAS46tCZjvL9nBVMyKVqEzPKPdzCuYL
 FFyUor3+ZPLOkaW5pYj66AsTTYmyh5MaXakecPV5rYV3eer5F9KlOIzcPfMLdf0jAFK/
 1uVg==
X-Gm-Message-State: AOAM530tB55ak6Oo8yvT3KLKiPRK7sVAW+uS3cR0aLa8AxIiyVdH2rGG
 RLtG63tI+djznOifKrUZNhzjRMnmWGKGIC721u4=
X-Google-Smtp-Source: ABdhPJwIaFTzMq52uc8XptnLoovSkpBBAkRrELwDLTmDJk2MavBc3AEIhegXJKnM2KqFOMp1PKMOaK+kgcjBhthjk98=
X-Received: by 2002:a6b:f909:: with SMTP id j9mr8119682iog.184.1602210137119; 
 Thu, 08 Oct 2020 19:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <47dbcad4-3121-b1c3-06fa-abec7c353fb6@gmail.com>
 <87sgatanti.fsf@linaro.org>
 <CAFEAcA_ZMLV3DZ_R_SHvPLdEf=i-xpspD5itBmfYeqyMhgtLWQ@mail.gmail.com>
 <875z7p3t9e.fsf@linaro.org> <e43be86d-1847-199f-4cbd-2e3bd124d70a@gmail.com>
 <CADBGO794+ZPD=B=dFuA7SC96g3GDJXF1A8j=VP6MeiSw1Sf4oQ@mail.gmail.com>
 <d8d79b4c-aeb4-4f07-7110-91d8d1afd701@gmail.com> <87362r3cbt.fsf@linaro.org>
 <61c49583-c548-a8b2-7106-59011196f430@gmail.com>
 <CADBGO7-BaTH3MBZa6Dbv2+uxKNbv3ztwQ=iu_FCgrcrKBUzCPw@mail.gmail.com>
 <4da67d13-a774-f62e-ad89-de062cbe81da@gmail.com> <87blhe1esd.fsf@linaro.org>
 <f32593d0-e87b-0549-7b59-f58da24c9130@gmail.com> <87362q1bxl.fsf@linaro.org>
 <2e3754fb-8b3c-4ef2-989f-a0015ef3a7e8@gmail.com>
 <CADBGO79XkF7hAxDmrPm9Za16rXPHbB2L6xD2zr8puDLQp+z0Fw@mail.gmail.com>
In-Reply-To: <CADBGO79XkF7hAxDmrPm9Za16rXPHbB2L6xD2zr8puDLQp+z0Fw@mail.gmail.com>
From: Paul Zimmerman <pauldzim@gmail.com>
Date: Thu, 8 Oct 2020 19:21:50 -0700
Message-ID: <CADBGO7_taH6z3x-Ab3rtxUJ_FrFL3ULexO=CJsMoynbvCGazaw@mail.gmail.com>
Subject: Re: Emulate Rpi with QEMU fails
To: Thomas <74cmonty@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2e;
 envelope-from=pauldzim@gmail.com; helo=mail-io1-xd2e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Running 'top -H' (to show individual threads) I see qemu is using 6 to 7
threads while running, and each thread is taking from 15% to 70% or so
of cpu time. So probably qemu is not able to spread the work among the
threads evenly enough to use all the cpu time available.

Might be an interesting area of investigation for someone motivated
enough :)

- Paul

On Thu, Oct 8, 2020 at 2:07 PM Paul Zimmerman <pauldzim@gmail.com> wrote:
>
> Hi Thomas,
>
> What does 'top' say while the emulation is running? I have an 8 cpu-threa=
d
> system, yet 'top' never shows more than about 300% cpu. I would have
> thought it would get closer to 800% cpu. And running qemu as root with
> nice -20 doesn't seem to make much difference.
>
> - Paul
>
> On Thu, Oct 8, 2020 at 12:00 AM Thomas <74cmonty@gmail.com> wrote:
> >
> > Interesting enough is: my top figure reported by perf is like yours:
> >
> > Samples: 6M of event 'cycles:u', Event count (approx.): 1936571734942
> > Overhead  Command          Shared Object                  Symbol
> >    7,95%  qemu-system-arm  qemu-system-arm                [.]
> > helper_lookup_tb_ptr
> > =E2=97=86
> >    4,16%  qemu-system-arm  qemu-system-arm                [.]
> > cpu_get_tb_cpu_state
> > =E2=96=92
> >    2,52%  qemu-system-arm  libpthread-2.32.so             [.]
> > __pthread_mutex_lock
> > =E2=96=92
> >    2,06%  qemu-system-arm  qemu-system-arm                [.]
> > qht_lookup_custom
> > =E2=96=92
> >    1,66%  qemu-system-arm  qemu-system-arm                [.]
> > tlb_set_page_with_attrs
> > =E2=96=92
> >    1,61%  qemu-system-arm  libpthread-2.32.so             [.]
> > __pthread_mutex_unlock_usercnt
> > =E2=96=92
> >    1,59%  qemu-system-arm  qemu-system-arm                [.]
> > get_phys_addr
> > =E2=96=92
> >    1,27%  qemu-system-arm  qemu-system-arm                [.]
> > cpu_exec
> > =E2=96=92
> >    1,23%  qemu-system-arm  qemu-system-arm                [.]
> > object_class_dynamic_cast_assert
> > =E2=96=92
> >    0,98%  qemu-system-arm  libc-2.32.so                   [.]
> > _int_malloc
> > =E2=96=92
> >    0,95%  qemu-system-arm  qemu-system-arm                [.]
> > object_dynamic_cast_assert
> > =E2=96=92
> >    0,95%  qemu-system-arm  qemu-system-arm                [.]
> > tb_htable_lookup
> > =E2=96=92
> >    0,92%  qemu-system-arm  qemu-system-arm                [.]
> > tcg_gen_code
> > =E2=96=92
> >    0,91%  qemu-system-arm  qemu-system-arm                [.]
> > qemu_mutex_lock_impl
> > =E2=96=92
> >    0,75%  qemu-system-arm  qemu-system-arm                [.]
> > get_page_addr_code_hostp
> > =E2=96=92
> >    0,73%  qemu-system-arm  qemu-system-arm                [.]
> > tcg_optimize
> > =E2=96=92
> >    0,71%  qemu-system-arm  qemu-system-arm                [.]
> > qemu_mutex_unlock_impl
> > =E2=96=92
> >    0,69%  qemu-system-arm  libc-2.32.so                   [.]
> > _int_free
> > =E2=96=92
> >    0,64%  qemu-system-arm  qemu-system-arm                [.]
> > tb_flush_jmp_cache
> > =E2=96=92
> >    0,63%  qemu-system-arm  qemu-system-arm                [.]
> > address_space_ldl_le
> > =E2=96=92
> >    0,62%  qemu-system-arm  libpthread-2.32.so             [.]
> > __lll_lock_wait
> > =E2=96=92
> >    0,58%  qemu-system-arm  libpthread-2.32.so             [.]
> > pthread_cond_wait@@GLIBC_2.3.2
> > =E2=96=92
> >    0,52%  qemu-system-arm  qemu-system-arm                [.]
> > cpu_reset_interrupt
> > =E2=96=92
> >    0,52%  qemu-system-arm  libc-2.32.so                   [.]
> > cfree@GLIBC_2.2.5
> > =E2=96=92
> >    0,52%  qemu-system-arm  qemu-system-arm                [.]
> > qemu_set_irq
> > =E2=96=92
> >
> > However the absolute time is 3-4 minutes.
> > And I don't know where I should start optimization now.
> >
> >
> >
> > Am 07.10.20 um 14:02 schrieb Alex Benn=C3=A9e:
> > > Thomas Schneider <74cmonty@gmail.com> writes:
> > >
> > >> Are you referring to this tool?
> > >> https://github.com/stefano-garzarella/qemu-boot-time
> > >> <https://github.com/stefano-garzarella/qemu-boot-time>
> > > No - just plain perf:
> > >
> > >   perf record $QEMU $ARGS
> > >
> > > Then a "perf report" which will show you the hotspots, for example:
> > >
> > >    8.92%  qemu-system-aar  qemu-system-aarch64      [.] helper_lookup=
_tb_ptr
> > >    4.76%  qemu-system-aar  qemu-system-aarch64      [.] liveness_pass=
_1
> > >    3.69%  qemu-system-aar  qemu-system-aarch64      [.] tcg_gen_code
> > >    2.95%  qemu-system-aar  qemu-system-aarch64      [.] qht_lookup_cu=
stom
> > >    2.93%  qemu-system-aar  qemu-system-aarch64      [.] tcg_optimize
> > >    1.28%  qemu-system-aar  qemu-system-aarch64      [.] tcg_out_opc.i=
sra.15
> > >    1.09%  qemu-system-aar  qemu-system-aarch64      [.] get_phys_addr=
_lpae
> > >    1.09%  qemu-system-aar  [kernel.kallsyms]        [k] isolate_freep=
ages_block
> > >    1.05%  qemu-system-aar  qemu-system-aarch64      [.] cpu_get_tb_cp=
u_state
> > >    0.98%  qemu-system-aar  [kernel.kallsyms]        [k] do_syscall_64
> > >    0.94%  qemu-system-aar  qemu-system-aarch64      [.] tb_lookup_cmp
> > >    0.78%  qemu-system-aar  qemu-system-aarch64      [.] init_ts_info
> > >    0.73%  qemu-system-aar  qemu-system-aarch64      [.] tb_htable_loo=
kup
> > >    0.73%  qemu-system-aar  qemu-system-aarch64      [.] tb_gen_code
> > >    0.73%  qemu-system-aar  qemu-system-aarch64      [.] tlb_set_page_=
with_attrs
> > >
> > >>
> > >> Am 07.10.2020 um 13:00 schrieb Alex Benn=C3=A9e:
> > >>> perf to record your boot
> > >
> >

