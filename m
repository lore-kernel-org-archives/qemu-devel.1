Return-Path: <SRS0=QItv=AX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72401C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 09:59:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3432A206F0
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 09:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GZ8+sxW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3432A206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juYlI-0002v3-Gk
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 05:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1juYkk-0002VS-PP
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 05:58:34 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35512)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1juYki-0004hi-Ok
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 05:58:34 -0400
Received: by mail-wm1-x343.google.com with SMTP id l2so10097129wmf.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2020 02:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Zen7/eQrx1+fGbiQOkBbFqanCSch2HgHvtDGEQRX9+M=;
 b=GZ8+sxW6rf1XxUQNl/yJRxndZcOiHPHK71fDZDBij6oVEbDESli+WnAo5yWn5wL/X4
 5KBuqyUiWRg+8OgK0G8mnnATox1/hxFIjqLq3UjTamRLluEGYjXxg+6EnzfvZDwoP6Zl
 Dg3la/652beuazHuZTN5uYo3K6HCMcXE0Jh9jA5wnIZvURpr0yOoKmXqyG0HrO+S7lKW
 AJ3yTflOB5+sx6rzfzTiw0PfnIhe4pWWFwL5seV77jKxDb23YsaVFBvNgcccv6yHS5Sx
 lJE8O1vZ4ROdQhWLdJ0Y7WzYVj9d9f7LAJdZczJWBUZWbgtOrLmRo/Zn60pTuCr8ImzM
 kO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Zen7/eQrx1+fGbiQOkBbFqanCSch2HgHvtDGEQRX9+M=;
 b=RCnDjGKjDlz5QyRTfAmNUfOFMlEAzYK1wipthjkuhwDkKJC+SQpl/ckdCTcfBHi6AC
 hZPIkg3UayMLtWBXq4T8xjl6eAv7xgmasL8pDUtuElRimrR7mv/r4K7RHnci8iK4cJFr
 IDoRb6RIZcxP+lkb6lutadd9Pz3oE+IiS/M8tWNVkPPR0OfrXM62JoJ/NsM+pn1ralY/
 4oSHcUeic/B+0ED+6n9n+/3e2iTlP4E2GbLM46m4GtvV14r4sIeBBPh9J75MQbnIA5GI
 ZeBXmyiFV+InwDl/BC+ahTcoFQ93GxRtaiLzb3cXE6levHM7iO43HG6Od1KXXdghJk9k
 eTJQ==
X-Gm-Message-State: AOAM532xst1i/zoz0NO78pEueUtruJqB0UtBasBpelwLBQH17tu/6Ymo
 nbagc+xOvDZveq1NSv7C/9whrg==
X-Google-Smtp-Source: ABdhPJwDsiZ5E+OPB62Tjy3yyC85aQQcEzCQC6xESyCYBT3cZs4T4zzw9cgu4QEPYuz3SWRoIM+/Vg==
X-Received: by 2002:a1c:4d04:: with SMTP id o4mr13345459wmh.132.1594547910780; 
 Sun, 12 Jul 2020 02:58:30 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n5sm17225681wmi.34.2020.07.12.02.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2020 02:58:29 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 14B361FF7E;
 Sun, 12 Jul 2020 10:58:29 +0100 (BST)
References: <20200709141327.14631-1-alex.bennee@linaro.org>
 <20200709141327.14631-5-alex.bennee@linaro.org>
 <7ebfe683-5c6b-064b-7bab-3b9624f0a3f8@linaro.org>
 <20200711213039.GD807960@sff>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Emilio G. Cota" <cota@braap.org>
Subject: Re: [PATCH v1 04/13] cputlb: ensure we save the IOTLB data in case
 of reset
In-reply-to: <20200711213039.GD807960@sff>
Date: Sun, 12 Jul 2020 10:58:29 +0100
Message-ID: <87imetqcl6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: fam@euphon.net, Peter Maydell <peter.maydell@linaro.org>,
 berrange@redhat.com, robert.foley@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 robhenry@microsoft.com, f4bug@amsat.org, aaron@os.amperecomputing.com,
 Paolo Bonzini <pbonzini@redhat.com>, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org, Eduardo Habkost <ehabkost@redhat.com>,
 aurelien@aurel32.net, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Emilio G. Cota <cota@braap.org> writes:

> On Fri, Jul 10, 2020 at 14:03:27 -0700, Richard Henderson wrote:
>> On 7/9/20 7:13 AM, Alex Benn=C3=A9e wrote:
>> > Any write to a device might cause a re-arrangement of memory
>> > triggering a TLB flush and potential re-size of the TLB invalidating
>> > previous entries. This would cause users of qemu_plugin_get_hwaddr()
>> > to see the warning:
>> >=20
>> >   invalid use of qemu_plugin_get_hwaddr
>> >=20
>> > because of the failed tlb_lookup which should always succeed. To
>> > prevent this we save the IOTLB data in case it is later needed by a
>> > plugin doing a lookup.
>> >=20
>> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> >=20
>> > ---
>> > v2
>> >   - save the entry instead of re-running the tlb_fill.
>> > v3
>> >   - don't abuse TLS, use CPUState to store data
>> >   - just use g_free_rcu() to avoid ugliness
>> >   - verify addr matches before returning data
>> >   - ws fix
>> > ---
>> >  include/hw/core/cpu.h   |  4 +++
>> >  include/qemu/typedefs.h |  1 +
>> >  accel/tcg/cputlb.c      | 57 +++++++++++++++++++++++++++++++++++++++--
>> >  3 files changed, 60 insertions(+), 2 deletions(-)
>> >=20
>> > diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
>> > index b3f4b7931823..bedbf098dc57 100644
>> > --- a/include/hw/core/cpu.h
>> > +++ b/include/hw/core/cpu.h
>> > @@ -417,7 +417,11 @@ struct CPUState {
>> >=20=20
>> >      DECLARE_BITMAP(plugin_mask, QEMU_PLUGIN_EV_MAX);
>> >=20=20
>> > +#ifdef CONFIG_PLUGIN
>> >      GArray *plugin_mem_cbs;
>> > +    /* saved iotlb data from io_writex */
>> > +    SavedIOTLB *saved_iotlb;
>> > +#endif
>> >=20=20
>> >      /* TODO Move common fields from CPUArchState here. */
>> >      int cpu_index;
>> > diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
>> > index 15f5047bf1dc..427027a9707a 100644
>> > --- a/include/qemu/typedefs.h
>> > +++ b/include/qemu/typedefs.h
>> > @@ -116,6 +116,7 @@ typedef struct QObject QObject;
>> >  typedef struct QString QString;
>> >  typedef struct RAMBlock RAMBlock;
>> >  typedef struct Range Range;
>> > +typedef struct SavedIOTLB SavedIOTLB;
>> >  typedef struct SHPCDevice SHPCDevice;
>> >  typedef struct SSIBus SSIBus;
>> >  typedef struct VirtIODevice VirtIODevice;
>> > diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
>> > index 1e815357c709..8636b66e036a 100644
>> > --- a/accel/tcg/cputlb.c
>> > +++ b/accel/tcg/cputlb.c
>> > @@ -1073,6 +1073,42 @@ static uint64_t io_readx(CPUArchState *env, CPU=
IOTLBEntry *iotlbentry,
>> >      return val;
>> >  }
>> >=20=20
>> > +#ifdef CONFIG_PLUGIN
>> > +
>> > +typedef struct SavedIOTLB {
>> > +    struct rcu_head rcu;
>> > +    hwaddr addr;
>> > +    MemoryRegionSection *section;
>> > +    hwaddr mr_offset;
>> > +} SavedIOTLB;
>> > +
>> > +/*
>> > + * Save a potentially trashed IOTLB entry for later lookup by plugin.
>> > + *
>> > + * We also need to track the thread storage address because the RCU
>> > + * cleanup that runs when we leave the critical region (the current
>> > + * execution) is actually in a different thread.
>> > + */
>> > +static void save_iotlb_data(CPUState *cs, hwaddr addr, MemoryRegionSe=
ction *section, hwaddr mr_offset)
>>=20
>> Overlong line.
>>=20
>> > +{
>> > +    SavedIOTLB *old, *new =3D g_new(SavedIOTLB, 1);
>> > +    new->addr =3D addr;
>> > +    new->section =3D section;
>> > +    new->mr_offset =3D mr_offset;
>> > +    old =3D atomic_rcu_read(&cs->saved_iotlb);
>> > +    atomic_rcu_set(&cs->saved_iotlb, new);
>> > +    if (old) {
>> > +        g_free_rcu(old, rcu);
>> > +    }
>> > +}
>>=20
>> I'm a bit confused by this.  Why all the multiple allocation?  How many
>> consumers are you expecting, and more are you expecting multiple memory
>> operations in flight at once?
>>=20
>> If multiple memory operations in flight, then why aren't we chaining them
>> together, so that you can search through multiple alternatives.
>>=20
>> If only one memory operation in flight, why are you allocating memory at=
 all,
>> much less managing it with rcu?  Just put one structure (or a collection=
 of
>> fields) into CPUState and be done.
>
> Oh I just saw this reply. I subscribe all of the above, please shelve my =
R-b
> tag until these are resolved.

I was just conscious the data is not always valid - clearing it up with
RCU at least ensured it went away eventually. However we could certainly
just park it in the general CPUState and assert the match on the fall
through case of tlb_plugin_lookup.

My only worry is do we ever see us storing data that is valid but the
re-filled data in the real TLB could still match and be incorrect?

> An alternative is to emit the hwaddr directly in the mem_cb -- IIRC this =
is
> how I did it originally. The API is a larger/uglier (plugins can subscribe
> to either hwaddr or vaddr callbacks) but there is no state to keep and
> no overhead of calling several functions in a hot path.

I think that is certainly an option for evolving the API but I'd rather
just get this fix in for now while we ponder what else will be in v2 of
the API.

So far my proposal for qemu_plugin_hwaddr_device_name has some mild push
back from Peter which I'd like to resolve first:

  Date: Wed, 3 Jun 2020 16:48:33 +0100
  Message-ID: <CAFEAcA-kPZoumxfLgjxPfCPDmPgsAFCjB-zdicsiGeqSOPOH7Q@mail.gma=
il.com>

So far I've been adding stuff to solve any particular problems I've had
and I'd like to see what other API/hooks are being proposed so we don't
have browser style version ticks ;-)

>
> Thanks,
> 		E.


--=20
Alex Benn=C3=A9e

