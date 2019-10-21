Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0B2CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 15:08:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D914F20659
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 15:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GBFhkjZs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D914F20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMZIP-0000vf-38
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 11:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iMZHO-00082G-MH
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:07:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iMZHM-0000Uw-E6
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:07:30 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:39830)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iMZHM-0000UR-58
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:07:28 -0400
Received: by mail-io1-xd42.google.com with SMTP id a1so16297801ioc.6
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 08:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=J4jfBO9dXtycoQ+LUnfDkjC9DiMBC/ilexkuliLwlrs=;
 b=GBFhkjZs3/EqZPRjhjJvXaK5R5NCzNf+OEQQFCpDUVnW/J6uaKwhFix0ruovsKbbwz
 +0lfyoB7mTywJWIaRkn2FGoXCyNONOD0jEcgRNWJ3h7vdQbN0bWKtQDIU6QgFoLozzjB
 DuPc55mkNEVEJlZWyGQdn+rqtJg+J708Tb6TNaiVdHwzxKF3LpF81XnL3ibbP1OcohQT
 k0Cf1JIQU6EodQVCZqDvLV9p8W31IxAbZJBGT8AE7aVeUqYme1MeTa793ab/CCZM2nFs
 Ii5mcoIoxYoQwoP9si/245e8cW3Jt6iFory1u3rx289s2MO3WjBYnJq/t/ggiFF0vD7v
 1+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=J4jfBO9dXtycoQ+LUnfDkjC9DiMBC/ilexkuliLwlrs=;
 b=e/js3ge2Bhltg4mxidz1gsuZlMpknOjXiSvPyoQQ3JabDkHeYjtMPB/W0wEwgenMYK
 xiNGQ0QEIy2e63aTsf8KtxpO9Y0Vs6P/7jYFsl1gG+DdiCbgDUXlPD1nb/SGiRsqq15o
 mMbF5qeo2r1nJorvSFZqWZWko2fBOM+8OsjMDPCjulrk9kPV+lp9deYPAJXGh2Asrptq
 BU07Vnx3o6FPSPTe+brcFWmRlCZIALdpfpfWm3KUL9CwA/FB/hzfJExCFzdWCnX+IV2j
 tZz7WT26VgkOmKQZvShjwkoNtJOOrppwik0JpXj1OQHbcsxuw2drPW4TKJpwWmvNLxWf
 nFGQ==
X-Gm-Message-State: APjAAAV0/9LZxmd2Kbztyxvi8cjzoPidIKoMRJy6qVyPP+3B/aljuh5K
 d3WDEBfvBoGCoILgN7ERvZfBDuqIo+trAPFx93u7tA==
X-Google-Smtp-Source: APXvYqx+wpP5BAvbjCXt7EEaOlxpHGI6k7tWAYEWcMy/096DVjVdOiussbKy/93aCeMJw6Zb8TFJelcYJeQ/+FvBY3U=
X-Received: by 2002:a02:330e:: with SMTP id c14mr22992138jae.5.1571670446225; 
 Mon, 21 Oct 2019 08:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <20191001125845.8793-1-drjones@redhat.com>
 <20191001125845.8793-2-drjones@redhat.com>
 <CADSWDztJDUEd+_7XnBPWL1bk5Xh=V_aLc1+VrP97_Ycbe3489A@mail.gmail.com>
 <20191015105628.7ln6ph5s3vpsyfuw@kamzik.brq.redhat.com>
 <CADSWDzsKx7+4mR4pmsqi0+rddUv47q=UKwVt509B8g68UoRiMA@mail.gmail.com>
 <CADSWDzs9sdjE+-1AedPnU6o7U5XjTk=dcHf-BXQXQQkrp2O=Bw@mail.gmail.com>
 <20191016135025.k4szpqwgkhfnd6dl@kamzik.brq.redhat.com>
 <CADSWDzuXpTHDtRmTL41CXbk9GmDHO5iEgpiRgnD=buQU+nnXcg@mail.gmail.com>
 <20191016161628.rf752xuu6fzkihun@kamzik.brq.redhat.com>
In-Reply-To: <20191016161628.rf752xuu6fzkihun@kamzik.brq.redhat.com>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Mon, 21 Oct 2019 16:07:14 +0100
Message-ID: <CADSWDzvT7E9P3uEJDV9z+L=HEBuDRwQ904-GG0M9T-NUz+OsoQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] target/arm/monitor: Introduce
 qmp_query_cpu_model_expansion
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
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
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 armbru@redhat.com, eric.auger@redhat.com, qemu-arm@nongnu.org,
 imammedo@redhat.com, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 16 Oct 2019 at 17:16, Andrew Jones <drjones@redhat.com> wrote:
>
> On Wed, Oct 16, 2019 at 04:16:57PM +0100, Beata Michalska wrote:
> > On Wed, 16 Oct 2019 at 14:50, Andrew Jones <drjones@redhat.com> wrote:
> > >
> > > On Wed, Oct 16, 2019 at 02:24:50PM +0100, Beata Michalska wrote:
> > > > On Tue, 15 Oct 2019 at 12:56, Beata Michalska
> > > > <beata.michalska@linaro.org> wrote:
> > > > >
> > > > > On Tue, 15 Oct 2019 at 11:56, Andrew Jones <drjones@redhat.com> wrote:
> > > > > >
> > > > > > On Tue, Oct 15, 2019 at 10:59:16AM +0100, Beata Michalska wrote:
> > > > > > > On Tue, 1 Oct 2019 at 14:04, Andrew Jones <drjones@redhat.com> wrote:
> > > > > > > > +
> > > > > > > > +    obj = object_new(object_class_get_name(oc));
> > > > > > > > +
> > > > > > > > +    if (qdict_in) {
> > > > > > > > +        Visitor *visitor;
> > > > > > > > +        Error *err = NULL;
> > > > > > > > +
> > > > > > > > +        visitor = qobject_input_visitor_new(model->props);
> > > > > > > > +        visit_start_struct(visitor, NULL, NULL, 0, &err);
> > > > > > > > +        if (err) {
> > > > > > > > +            object_unref(obj);
> > > > > > >
> > > > > > > Shouldn't we free the 'visitor' here as well ?
> > > > > >
> > > > > > Yes. Good catch. So we also need to fix
> > > > > > target/s390x/cpu_models.c:cpu_model_from_info(), which has the same
> > > > > > construction (the construction from which I derived this)
> > > > > >
> > > > > > >
> > > > > > > > +            error_propagate(errp, err);
> > > > > > > > +            return NULL;
> > > > > > > > +        }
> > > > > > > > +
> > > > > >
> > > > > > What about the rest of the patch? With that fixed for v6 can I
> > > > > > add your r-b?
> > > > > >
> > > > >
> > > > > I still got this feeling that we could optimize that a bit - which I'm
> > > > > currently on, so hopefully I'll be able to add more comments soon if
> > > > > that proves to be the case.
> > > > >
> > > > > BR
> > > > > Beata
> > > >
> > > > I think there are few options that might be considered though the gain
> > > > is not huge .. but it's always smth:
> > > >
> > > > > +CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
> > > > > +                                                     CpuModelInfo *model,
> > > > > +                                                     Error **errp)
> > > > > +{
> > > > > +    CpuModelExpansionInfo *expansion_info;
> > > > > +    const QDict *qdict_in = NULL;
> > > > > +    QDict *qdict_out;
> > > > > +    ObjectClass *oc;
> > > > > +    Object *obj;
> > > > > +    const char *name;
> > > > > +    int i;
> > > > > +
> > > > > +    if (type != CPU_MODEL_EXPANSION_TYPE_FULL) {
> > > > > +        error_setg(errp, "The requested expansion type is not supported");
> > > > > +        return NULL;
> > > > > +    }
> > > > > +
> > > > > +    if (!kvm_enabled() && !strcmp(model->name, "host")) {
> > > > > +        error_setg(errp, "The CPU type '%s' requires KVM", model->name);
> > > > > +        return NULL;
> > > > > +    }
> > > > > +
> > > > > +    oc = cpu_class_by_name(TYPE_ARM_CPU, model->name);
> > > > > +    if (!oc) {
> > > > > +        error_setg(errp, "The CPU type '%s' is not a recognized ARM CPU type",
> > > > > +                   model->name);
> > > > > +        return NULL;
> > > > > +    }
> > > > > +
> > > > > +    if (kvm_enabled()) {
> > > > > +        const char *cpu_type = current_machine->cpu_type;
> > > > > +        int len = strlen(cpu_type) - strlen(ARM_CPU_TYPE_SUFFIX);
> > > > > +        bool supported = false;
> > > > > +
> > > > > +        if (!strcmp(model->name, "host") || !strcmp(model->name, "max")) {
> > > > > +            /* These are kvmarm's recommended cpu types */
> > > > > +            supported = true;
> > > > > +        } else if (strlen(model->name) == len &&
> > > > > +                   !strncmp(model->name, cpu_type, len)) {
> > > > > +            /* KVM is enabled and we're using this type, so it works. */
> > > > > +            supported = true;
> > > > > +        }
> > > > > +        if (!supported) {
> > > > > +            error_setg(errp, "We cannot guarantee the CPU type '%s' works "
> > > > > +                             "with KVM on this host", model->name);
> > > > > +            return NULL;
> > > > > +        }
> > > > > +    }
> > > > > +
> > > >
> > > > The above section can be slightly reduced and rearranged - preferably
> > > > moved to a separate function
> > > > -> get_cpu_model (...) ?
> > > >
> > > > * You can check the 'host' model first and then validate the accelerator ->
> > > >     if ( !strcmp(model->name, "host")
> > > >         if (!kvm_enabled())
> > > >             log_error & leave
> > > >        else
> > > >           goto cpu_class_by_name /*cpu_class_by_name moved after the
> > > > final model check @see below */
> > > >
> > > > * the kvm_enabled section can be than slightly improved (dropping the
> > > > second compare against 'host')
> > > >
> > > >       if (kvm_enabled() && strcmp(model->name, "max") {
> > > >            /*Validate the current_machine->cpu_type against the
> > > > model->name and report error case mismatch
> > > >           /* otherwise just fall through */
> > > >       }
> > > >  * cpu_class_by_name moved here ...
> > > > > +    if (model->props) {
> > > > MInor: the CPUModelInfo seems to have dedicated field for that
> > > > verification -> has_props
> > > >
> > > > > +        qdict_in = qobject_to(QDict, model->props);
> > > > > +        if (!qdict_in) {
> > > > > +            error_setg(errp, QERR_INVALID_PARAMETER_TYPE, "props", "dict");
> > > > > +            return NULL;
> > > > > +        }
> > > > > +    }
> > > > > +
> > > > > +    obj = object_new(object_class_get_name(oc));
> > > > > +
> > > > > +    if (qdict_in) {
> > > > > +        Visitor *visitor;
> > > > > +        Error *err = NULL;
> > > > > +
> > > > > +        visitor = qobject_input_visitor_new(model->props);
> > > > > +        visit_start_struct(visitor, NULL, NULL, 0, &err);
> > > > > +        if (err) {
> > > > > +            object_unref(obj);
> > > > > +            error_propagate(errp, err);
> > > > > +            return NULL;
> > > > > +        }
> > > > > +
> > > > > +        i = 0;
> > > > > +        while ((name = cpu_model_advertised_features[i++]) != NULL) {
> > > > > +            if (qdict_get(qdict_in, name)) {
> > > > > +                object_property_set(obj, visitor, name, &err);
> > > > > +                if (err) {
> > > > > +                    break;
> > > > > +                }
> > > > > +            }
> > > > > +        }
> > > > > +
> > > > > +        if (!err) {
> > > > > +            visit_check_struct(visitor, &err);
> > > > > +        }
> > > > > +        visit_end_struct(visitor, NULL);
> > > > > +        visit_free(visitor);
> > > > > +        if (err) {
> > > > > +            object_unref(obj);
> > > > > +            error_propagate(errp, err);
> > > > > +            return NULL;
> > > > > +        }
> > > > > +    }
> > > >
> > > > The both >> if (err) << blocks could be extracted and moved at the end
> > > > of the function
> > > > to mark a 'cleanup section'  and both here and few lines before
> > > > (with the visit_start_struct failure) could use goto.
> > > > Easier to maintain and to make sure we make the proper cleanup in any case.
> > > >
> > > > > +
> > > > > +    expansion_info = g_new0(CpuModelExpansionInfo, 1);
> > > > > +    expansion_info->model = g_malloc0(sizeof(*expansion_info->model));
> > > > > +    expansion_info->model->name = g_strdup(model->name);
> > > > > +
> > > > > +    qdict_out = qdict_new();
> > > > > +
> > > > > +    i = 0;
> > > > > +    while ((name = cpu_model_advertised_features[i++]) != NULL) {
> > > > > +        ObjectProperty *prop = object_property_find(obj, name, NULL);
> > > > > +        if (prop) {
> > > > > +            Error *err = NULL;
> > > > > +            QObject *value;
> > > > > +
> > > > > +            assert(prop->get);
> > > > > +            value = object_property_get_qobject(obj, name, &err);
> > > > > +            assert(!err);
> > > > > +
> > > > > +            qdict_put_obj(qdict_out, name, value);
> > > > > +        }
> > > > > +    }
> > > > > +
> > > >
> > > > This could be merged with the first iteration over the features,
> > > > smth like:
> > > >
> > > >     while () {
> > > >         if ((value = qdict_get(qdict_in, name))) {
> > > >             object_property_set ...
> > > >            if (!err)
> > > >                qobject_ref(value) /* we have the weak reference */
> > > >             else
> > > >                 break;
> > > >         } else {
> > > >              value = object_property_get_qobject()
> > > >         }
> > > >         if (value) qdict_put_object(qdict_out, name, value)
> > > >     }
> > > >
> > > > This way you iterate over the table once and you do not query
> > > > for the same property twice by getting the value from the qdict_in.
> > > > If the value is not acceptable we will fail either way so should be all good.
> > > >
> > > >
> > > > > +    if (!qdict_size(qdict_out)) {
> > > > > +        qobject_unref(qdict_out);
> > > > > +    } else {
> > > > > +        expansion_info->model->props = QOBJECT(qdict_out);
> > > > > +        expansion_info->model->has_props = true;
> > > > > +    }
> > > > > +
> > > > > +    object_unref(obj);
> > > > > +
> > > > > +    return expansion_info;
> > > >
> > > > Mentioned earlier cleanup section:
> > > > cleanup:
> > > >    object_unref(obj);
> > > >    qobject_unref(qdict_out) ; /* if single loop is used */
> > > >    error_propagate(errp,err);
> > > >    return NULL;
> > > >
> > > > > +}
> > > > > --
> > > > > 2.20.1
> > > > >
> > > >
> > > > Hope I haven't missed anything.
> > > > What do you think ?
> > > >
> > >
> > > I think you need to post an entire function that incorporates all the
> > > proposed changes, or at least a diff that I can apply in order to get
> > > the entirely changed function. I also think that it's fine the way
> > > it is, so it would take a justification stronger than a potential
> > > micro optimization to get me to change it.
> > >
> >
> > The numbers I can pull out of it are not thrilling and this is not
> > on a fast path so I will not be pushing for changes.
> > Though extracting the clean-up might be worth considering -
> > for improved maintenance.
> >
> > For a reference though:
>
> It doesn't apply for me - even after fixing up the damager your mailer did
> to it. I'd be surprised if it worked though. Merging the two loops over
> features makes the output generation depend on the caller providing input.
> Did you try the arm-cpu-features test with these changes?
>

Apologies for the late reply.

Indeed, the patch got bit messed-up. Apologies for that as well.
I have been testing manually but I did try the test you have provided
and yes it fails - there is a slight problem with the case when qdict_in
is empty,but this can be easily solved still keeping the single loop.
Otherwise I have seen you have posted a new patchest so I guess we  are
dropping the idea of refactoring ?

One more question: in case of querying a property which is not supported
by given cpu model - we are returning properties that are actually valid
(the test case for cortex-a15 and aarch64 prop).
Shouldn't we return an error there? I honestly must admit I do not know
what is the expected behaviour for the qmp query in such cases.

Best Regards
Beata



> drew
>
> >
> > _______________________________________________________
> >
> > ---
> >  target/arm/monitor.c | 100 +++++++++++++++++++++++++--------------------------
> >  1 file changed, 50 insertions(+), 50 deletions(-)
> >
> > diff --git a/target/arm/monitor.c b/target/arm/monitor.c
> > index edca8aa..0d6bd42 100644
> > --- a/target/arm/monitor.c
> > +++ b/target/arm/monitor.c
> > @@ -112,17 +112,40 @@ CpuModelExpansionInfo
> > *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
> >      Object *obj;
> >      const char *name;
> >      int i;
> > +    Error *err = NULL;
> >
> >      if (type != CPU_MODEL_EXPANSION_TYPE_FULL) {
> >          error_setg(errp, "The requested expansion type is not supported");
> >          return NULL;
> >      }
> >
> > -    if (!kvm_enabled() && !strcmp(model->name, "host")) {
> > -        error_setg(errp, "The CPU type '%s' requires KVM", model->name);
> > -        return NULL;
> > +    /* CPU type => 'host' */
> > +    if (!strcmp(model->name, "host")) {
> > +        if (!kvm_enabled()) {
> > +            error_setg(errp, "The CPU type '%s' requires KVM", model->name);
> > +            return NULL;
> > +        } else {
> > +            goto valid;
> > +        }
> > +    }
> > +
> > +
> > +    /* Case when KVM is enabled and the model is a specific cpu model ... */
> > +    if (kvm_enabled() && strcmp(model->name, "max")) {
> > +            const char *cpu_type = current_machine->cpu_type;
> > +            int len = strlen(cpu_type) - strlen("-" TYPE_ARM_CPU);
> > +
> > +            if (strlen(model->name) == len
> > +             && !strncmp(cpu_type, model->name, len)) {
> > +                error_setg(errp, "We cannot guarantee the CPU type '%s' works "
> > +                        "with KVM on this host", model->name);
> > +                return NULL;
> > +            }
> > +
> >      }
> >
> > +valid:
> > +
> >      oc = cpu_class_by_name(TYPE_ARM_CPU, model->name);
> >      if (!oc) {
> >          error_setg(errp, "The CPU type '%s' is not a recognized ARM CPU type",
> > @@ -130,25 +153,6 @@ CpuModelExpansionInfo
> > *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
> >          return NULL;
> >      }
> >
> > -    if (kvm_enabled()) {
> > -        const char *cpu_type = current_machine->cpu_type;
> > -        int len = strlen(cpu_type) - strlen(ARM_CPU_TYPE_SUFFIX);
> > -        bool supported = false;
> > -
> > -        if (!strcmp(model->name, "host") || !strcmp(model->name, "max")) {
> > -            /* These are kvmarm's recommended cpu types */
> > -            supported = true;
> > -        } else if (strlen(model->name) == len &&
> > -                   !strncmp(model->name, cpu_type, len)) {
> > -            /* KVM is enabled and we're using this type, so it works. */
> > -            supported = true;
> > -        }
> > -        if (!supported) {
> > -            error_setg(errp, "We cannot guarantee the CPU type '%s' works "
> > -                             "with KVM on this host", model->name);
> > -            return NULL;
> > -        }
> > -    }
> >
> >      if (model->props) {
> >          qdict_in = qobject_to(QDict, model->props);
> > @@ -159,62 +163,52 @@ CpuModelExpansionInfo
> > *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
> >      }
> >
> >      obj = object_new(object_class_get_name(oc));
> > +    qdict_out = qdict_new();
> >
> >      if (qdict_in) {
> >          Visitor *visitor;
> > -        Error *err = NULL;
> > +        QObject *value;
> >
> >          visitor = qobject_input_visitor_new(model->props);
> >          visit_start_struct(visitor, NULL, NULL, 0, &err);
> >          if (err) {
> > -            object_unref(obj);
> > -            error_propagate(errp, err);
> > -            return NULL;
> > +            visit_free(visitor);
> > +            goto cleanup;
> >          }
> > -
> >          i = 0;
> >          while ((name = cpu_model_advertised_features[i++]) != NULL) {
> > -            if (qdict_get(qdict_in, name)) {
> > +            value = qdict_get(qdict_in, name);
> > +            if (value) {
> >                  object_property_set(obj, visitor, name, &err);
> > -                if (err) {
> > +                if (!err) {
> > +                    qobject_ref(value);
> > +                } else {
> >                      break;
> >                  }
> > +
> > +            } else {
> > +               value = object_property_get_qobject(obj, name, &err);
> >              }
> > -        }
> >
> > +            if (value) {
> > +                qdict_put_obj(qdict_out, name, value);
> > +            }
> > +        }
> >          if (!err) {
> >              visit_check_struct(visitor, &err);
> >          }
> >          visit_end_struct(visitor, NULL);
> >          visit_free(visitor);
> >          if (err) {
> > -            object_unref(obj);
> > -            error_propagate(errp, err);
> > -            return NULL;
> > +            goto cleanup;
> >          }
> > +
> >      }
> >
> >      expansion_info = g_new0(CpuModelExpansionInfo, 1);
> >      expansion_info->model = g_malloc0(sizeof(*expansion_info->model));
> >      expansion_info->model->name = g_strdup(model->name);
> >
> > -    qdict_out = qdict_new();
> > -
> > -    i = 0;
> > -    while ((name = cpu_model_advertised_features[i++]) != NULL) {
> > -        ObjectProperty *prop = object_property_find(obj, name, NULL);
> > -        if (prop) {
> > -            Error *err = NULL;
> > -            QObject *value;
> > -
> > -            assert(prop->get);
> > -            value = object_property_get_qobject(obj, name, &err);
> > -            assert(!err);
> > -
> > -            qdict_put_obj(qdict_out, name, value);
> > -        }
> > -    }
> > -
> >      if (!qdict_size(qdict_out)) {
> >          qobject_unref(qdict_out);
> >      } else {
> > @@ -225,4 +219,10 @@ CpuModelExpansionInfo
> > *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
> >      object_unref(obj);
> >
> >      return expansion_info;
> > +
> > +cleanup:
> > +    object_unref(obj);
> > +    qobject_unref(qdict_out);
> > +    error_propagate(errp, err);
> > +    return NULL;
> >  }
> > --
> > 2.7.4
> >
> > BR
> > Beata
> >
> > > Thanks,
> > > drew
> >

