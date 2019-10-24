Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFE2CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:22:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6449C21906
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I/iMLLAJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6449C21906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNdzy-0007Y8-QP
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54612)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNcrZ-0001AW-UK
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:09:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNcrU-0007sN-FH
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:09:13 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:40515)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNcrU-0007rJ-6I
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:09:08 -0400
Received: by mail-wr1-x433.google.com with SMTP id o28so25999626wro.7
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 06:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Nl0+grapAWbnU0MgHxpuUZ4fTaIyjJKE/S1XIluE4AU=;
 b=I/iMLLAJo42ItFK9fIlEgFTH7JsJ0W8+xhXnakZiB2Tslc2+J2qV33wyNn+X3vFA1s
 ScTVZCluVBvwFZ3HCYbe2V6r+s3gVEQyrn4/H0r0NZL+6nHrjVz93Jn417VB67EZSZgu
 A4kbiMtrJHTeAS3SKtbfss5Fadvpp7y/AIIp57RATSrRTPWV1BvVjdA0LykUU8Wj9XOE
 5XY60NkGgDnfpNIj8+pyBM24oDhiKRl6x53ZzmlbaMPM2ob9/Wg6o4eKxbcLcthCLnLz
 40I3BbilYWhlSGYOGwVbPqT+hHQaLoyRD9WAnMBu9KakNorUKpy+G1bkp8hvD8mkhhZw
 hCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Nl0+grapAWbnU0MgHxpuUZ4fTaIyjJKE/S1XIluE4AU=;
 b=IJNG8r7DznWnniYRtn0F8HjF5HbP4dsD0IiyhPJEzVWjI2sneEwAMQIILVcTxQG0vU
 5Br9q7GtJEKrzmcE8bvQDCrBXK2FDN6eMBmVcLPnj3bPHECA3wAslsPkpKfnR7iL6Y04
 zicGQ/hEe16FOSNHaOIiD7YAz0j7kJE6yYIhDNdqeK0jTjAL7wkGs8+etWz1fDSkZA8Y
 zzsEhFAz4WB0qhpEgwztoptglMlb9wKP1eHubWv1d7oJZacGCDEIjHfA3cIa5TBirQ+4
 4syx8UUQILR3GuY2BTGlOFg4o4weM/EqaO+K0TNm0+qvGAPjqc3Y8r5T1h226PF7r+rg
 6ioQ==
X-Gm-Message-State: APjAAAXkFkztmI3BOQTvd1Aa2SOZA+euFPx5Q76Ag8yMODLN+csNHf7Z
 eXoNcTBap8hdsUxSczhOkUvUKw==
X-Google-Smtp-Source: APXvYqxAtk9tsVPQdP6MD80mXAkZElit5pTMi6bSixI6EihNgFBc2+7RpZfUNGIWKZTUSnsuj+lEcA==
X-Received: by 2002:adf:e38a:: with SMTP id e10mr4000117wrm.348.1571922546287; 
 Thu, 24 Oct 2019 06:09:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s12sm2435869wrp.18.2019.10.24.06.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 06:09:04 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1B9961FF87;
 Thu, 24 Oct 2019 14:09:03 +0100 (BST)
References: <20191017131615.19660-1-alex.bennee@linaro.org>
 <20191017131615.19660-38-alex.bennee@linaro.org>
 <20191018153214.GE42857@RDU-FVFX20TUHV2H> <87wod2nj5x.fsf@linaro.org>
 <20191022140347.GF42857@RDU-FVFX20TUHV2H>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Aaron Lindsay OS <aaron@os.amperecomputing.com>
Subject: Re: [PATCH  v6 37/54] plugin: expand the plugin_init function to
 include an info block
In-reply-to: <20191022140347.GF42857@RDU-FVFX20TUHV2H>
Date: Thu, 24 Oct 2019 14:09:03 +0100
Message-ID: <87d0emmgsw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
Cc: "robert.foley@futurewei.com" <robert.foley@futurewei.com>,
 "cota@braap.org" <cota@braap.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.puhov@futurewei.com" <peter.puhov@futurewei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Aaron Lindsay OS <aaron@os.amperecomputing.com> writes:

> On Oct 18 16:54, Alex Benn=C3=A9e wrote:
>>
>> Aaron Lindsay OS <aaron@os.amperecomputing.com> writes:
>>
>> > On Oct 17 14:15, Alex Benn=C3=A9e wrote:
>> >> +    const char *target_name;
>> >> +    /* is this a full system emulation? */
>> >> +    bool system_emulation;
>> >
>> > It seems that 'system_emulation' is meant primarily in opposition to
>> > user-mode. I'm wondering if this could/should this be an enum of the
>> > execution mode being used to allow for future expansion? Or, if your
>> > intention here is mostly to allow the user to detect when the *_vcpus
>> > variables are valid, could it be renamed or commented differently to
>> > make that link more clear?
>>
>> The only other operating mode that's ever been mooted is softmmu-user
>> (and no implementation has been done so far). Even then I don't think
>> that is a distinction that should be reported to the plugin as we are
>> trying not to leak implementation details.
>>
>> But yes the practical upshot is for system emulation you at least have
>> sort of bounded size for how many threads you may have running.
>
> Fair enough. My fear was that any other operating modes might require
> different plugin behavior, but it sounds like you think that unlikely.
> If we're attempting to keep the implementation details hidden, should we
> name this variable in terms of what it means for plugin implementations
> instead of what it means for QEMU? (Not sure this is a winner, but maybe
> something like "hardware_threading_model" )
>
>> >> +    info->target_name =3D TARGET_NAME;
>> >> +#ifndef CONFIG_USER_ONLY
>> >> +    MachineState *ms =3D MACHINE(qdev_get_machine());
>> >> +    info->system_emulation =3D true;
>> >> +    info->system.smp_vcpus =3D ms->smp.cpus;
>> >> +    info->system.max_vcpus =3D ms->smp.max_cpus;
>> >> +#else
>> >> +    info->system_emulation =3D false;
>> >
>> > Thinking "out loud" here - I wonder if it would be helpful to set the
>> > *_vcpus variables even for user mode here. It might allow unconditional
>> > allocation of "per-cpu" structures that the plugin might need - without
>> > first needing to check whether the *_vcpus variables were valid.
>>
>> but what too? It would certainly be wrong because any user-space process
>> could create (and destroy) thousands of threads.
>
> Hmm, right. To make sure I fully understand, does this mean that for
> user-mode, `vcpu_index` in the callback function pointer type below is
> actually the thread index?

No it is a monotonically increasing cpu_index for each new CPUState
created. So the first thread is 1 and the second is 2 no matter what the
thread id is.

> typedef void (*qemu_plugin_vcpu_simple_cb_t)(qemu_plugin_id_t id,
>                                              unsigned int vcpu_index);

We don't actually use this prototype anymore. I had removed the concept
of vcpu_index from the translation time hooks (so people don't get any
ideas about it's significance there). However we do use vcpu_index with
the udata form.

> If so, do we have some max number of threads we support? I suppose we
> could set max_vcpux to that number, and smp_cpus to 1, though I'm not
> sure if that would be helpful or not.
>
>> We could consider just asking plugins to deal with threads with their
>> own __thread variables but in that case we'd need to expose some sort of
>> thread exit/cleanup method so they can collect data from threads and
>> safely place it somewhere else - but I suspect that is a hairy
>> programming model to impose on plugins.
>>
>> So far all the example plugins have just used locks to serialise things
>> and it's not been too bad. I guess we could do with an example that
>> tries to use this information to get an idea of how grungy the interface
>> is. Perhaps exposing the vCPUs at this point is pointless and we should
>> just stick to TARGET_NAME for now?
>
> I'm not sure. I liked the idea of exposing the vCPUs because it
> theoretically allows you to allocate per-cpu things up front, which can
> be helpful... but maybe forcing users to deal with dynamically
> allocating everything will make for more resilient plugins anyway?

So we do use it in the example plugins (hotpages tracks which vCPUs have
written to which pages). I think it is useful information for a plugin
but I think if you want per-vCPU structures in your plugin __thread is
going to be the easiest solution.

--
Alex Benn=C3=A9e

