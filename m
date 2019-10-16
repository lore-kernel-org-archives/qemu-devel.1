Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D22AFA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 13:25:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BD0021848
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 13:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="su/0bL0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD0021848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKjJC-0007Do-Iu
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 09:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iKjIW-0006hF-OY
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 09:25:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iKjIU-0007nw-Tc
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 09:25:04 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:38641)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iKjIU-0007nD-Lq
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 09:25:02 -0400
Received: by mail-io1-xd44.google.com with SMTP id u8so53737512iom.5
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 06:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rh3wHqtVtFabbKAEcXsFCeQKY0cPR9zbmk3tXijHI4o=;
 b=su/0bL0eRerbHzWgt7aBUlweFzjlk8lGkHqp7I7KzHzHUyuz3gUsYpgckrhdlqD1xc
 7F5tBT4JEgfRLE0956CxH2vJVBmLNN7OYXXBq+/aM8czEkWey0NyLs1FGbDGfDzX40PL
 sQlc+Ro4Mg9lxcQxWEZY/K5dhoxU+3yY+8xbna6aE9gtqsbb2jJmuYPzBb9O5WSyplCN
 cfpYgk5aU2VpddSg6GErTTqonSk8zINbYvpEedbVAlGeQLUR2zyYfEDtMdVIXqCeXAsG
 5j2mQouJCn4lMxKl93l8a6/CK7Aay/JdGZEhjT5E7MW/yM+edu2YduCtVt1grV6hfzM7
 0Jrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rh3wHqtVtFabbKAEcXsFCeQKY0cPR9zbmk3tXijHI4o=;
 b=ihNg6XmaXKajNGztYPEvwuwEWhLfd7JrCd6KA14RJFmzwCjoPBTwHxZV3OFbVzl9bN
 RqhRuPEvDMvC+APiGbaT33S/I6w0SwV2j1nLv8G84Odr5ou8Y1/pPnwwg2xUqtGE2OBg
 zpLxq/MLoRN3abHlPjZzx7mYX46x/YamhQGldz64Zb05/eSHazClAnRwBY8ceEWr/nU/
 Pd88FMa8csUfjNr8ZTHP2WhblfkwY8JeH620aCMB1ZEp67Cjpzm+NokG57JmL+bjS1yS
 tWMUKPNjnPoab3PGCFUaYK1+DMGMC9taJHfTVBsX0LaTo4xMTW+iKrZseUSz2QKz3+jk
 gY5w==
X-Gm-Message-State: APjAAAW8raKXMiazKBieKJYrokkPMn9DIB8Dy5xDqd1X+Ly7S26kDw/R
 ZRKxbVwuU5Uy6noIIrdzaHk/aXlCv3jRSnu0Z+P/bA==
X-Google-Smtp-Source: APXvYqyJFpwlhAftQRywgD64sYYKFlpS6NtFcRIfd0zmGfA5+hk/Js1as8SpjbGV72kdWKNH/W8/JEuqdYISWpsJn4I=
X-Received: by 2002:a02:c90a:: with SMTP id t10mr46126163jao.89.1571232301194; 
 Wed, 16 Oct 2019 06:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191001125845.8793-1-drjones@redhat.com>
 <20191001125845.8793-2-drjones@redhat.com>
 <CADSWDztJDUEd+_7XnBPWL1bk5Xh=V_aLc1+VrP97_Ycbe3489A@mail.gmail.com>
 <20191015105628.7ln6ph5s3vpsyfuw@kamzik.brq.redhat.com>
 <CADSWDzsKx7+4mR4pmsqi0+rddUv47q=UKwVt509B8g68UoRiMA@mail.gmail.com>
In-Reply-To: <CADSWDzsKx7+4mR4pmsqi0+rddUv47q=UKwVt509B8g68UoRiMA@mail.gmail.com>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Wed, 16 Oct 2019 14:24:50 +0100
Message-ID: <CADSWDzs9sdjE+-1AedPnU6o7U5XjTk=dcHf-BXQXQQkrp2O=Bw@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] target/arm/monitor: Introduce
 qmp_query_cpu_model_expansion
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
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

On Tue, 15 Oct 2019 at 12:56, Beata Michalska
<beata.michalska@linaro.org> wrote:
>
> On Tue, 15 Oct 2019 at 11:56, Andrew Jones <drjones@redhat.com> wrote:
> >
> > On Tue, Oct 15, 2019 at 10:59:16AM +0100, Beata Michalska wrote:
> > > On Tue, 1 Oct 2019 at 14:04, Andrew Jones <drjones@redhat.com> wrote:
> > > > +
> > > > +    obj = object_new(object_class_get_name(oc));
> > > > +
> > > > +    if (qdict_in) {
> > > > +        Visitor *visitor;
> > > > +        Error *err = NULL;
> > > > +
> > > > +        visitor = qobject_input_visitor_new(model->props);
> > > > +        visit_start_struct(visitor, NULL, NULL, 0, &err);
> > > > +        if (err) {
> > > > +            object_unref(obj);
> > >
> > > Shouldn't we free the 'visitor' here as well ?
> >
> > Yes. Good catch. So we also need to fix
> > target/s390x/cpu_models.c:cpu_model_from_info(), which has the same
> > construction (the construction from which I derived this)
> >
> > >
> > > > +            error_propagate(errp, err);
> > > > +            return NULL;
> > > > +        }
> > > > +
> >
> > What about the rest of the patch? With that fixed for v6 can I
> > add your r-b?
> >
>
> I still got this feeling that we could optimize that a bit - which I'm
> currently on, so hopefully I'll be able to add more comments soon if
> that proves to be the case.
>
> BR
> Beata

I think there are few options that might be considered though the gain
is not huge .. but it's always smth:

> +CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
> +                                                     CpuModelInfo *model,
> +                                                     Error **errp)
> +{
> +    CpuModelExpansionInfo *expansion_info;
> +    const QDict *qdict_in = NULL;
> +    QDict *qdict_out;
> +    ObjectClass *oc;
> +    Object *obj;
> +    const char *name;
> +    int i;
> +
> +    if (type != CPU_MODEL_EXPANSION_TYPE_FULL) {
> +        error_setg(errp, "The requested expansion type is not supported");
> +        return NULL;
> +    }
> +
> +    if (!kvm_enabled() && !strcmp(model->name, "host")) {
> +        error_setg(errp, "The CPU type '%s' requires KVM", model->name);
> +        return NULL;
> +    }
> +
> +    oc = cpu_class_by_name(TYPE_ARM_CPU, model->name);
> +    if (!oc) {
> +        error_setg(errp, "The CPU type '%s' is not a recognized ARM CPU type",
> +                   model->name);
> +        return NULL;
> +    }
> +
> +    if (kvm_enabled()) {
> +        const char *cpu_type = current_machine->cpu_type;
> +        int len = strlen(cpu_type) - strlen(ARM_CPU_TYPE_SUFFIX);
> +        bool supported = false;
> +
> +        if (!strcmp(model->name, "host") || !strcmp(model->name, "max")) {
> +            /* These are kvmarm's recommended cpu types */
> +            supported = true;
> +        } else if (strlen(model->name) == len &&
> +                   !strncmp(model->name, cpu_type, len)) {
> +            /* KVM is enabled and we're using this type, so it works. */
> +            supported = true;
> +        }
> +        if (!supported) {
> +            error_setg(errp, "We cannot guarantee the CPU type '%s' works "
> +                             "with KVM on this host", model->name);
> +            return NULL;
> +        }
> +    }
> +

The above section can be slightly reduced and rearranged - preferably
moved to a separate function
-> get_cpu_model (...) ?

* You can check the 'host' model first and then validate the accelerator ->
    if ( !strcmp(model->name, "host")
        if (!kvm_enabled())
            log_error & leave
       else
          goto cpu_class_by_name /*cpu_class_by_name moved after the
final model check @see below */

* the kvm_enabled section can be than slightly improved (dropping the
second compare against 'host')

      if (kvm_enabled() && strcmp(model->name, "max") {
           /*Validate the current_machine->cpu_type against the
model->name and report error case mismatch
          /* otherwise just fall through */
      }
 * cpu_class_by_name moved here ...
> +    if (model->props) {
MInor: the CPUModelInfo seems to have dedicated field for that
verification -> has_props

> +        qdict_in = qobject_to(QDict, model->props);
> +        if (!qdict_in) {
> +            error_setg(errp, QERR_INVALID_PARAMETER_TYPE, "props", "dict");
> +            return NULL;
> +        }
> +    }
> +
> +    obj = object_new(object_class_get_name(oc));
> +
> +    if (qdict_in) {
> +        Visitor *visitor;
> +        Error *err = NULL;
> +
> +        visitor = qobject_input_visitor_new(model->props);
> +        visit_start_struct(visitor, NULL, NULL, 0, &err);
> +        if (err) {
> +            object_unref(obj);
> +            error_propagate(errp, err);
> +            return NULL;
> +        }
> +
> +        i = 0;
> +        while ((name = cpu_model_advertised_features[i++]) != NULL) {
> +            if (qdict_get(qdict_in, name)) {
> +                object_property_set(obj, visitor, name, &err);
> +                if (err) {
> +                    break;
> +                }
> +            }
> +        }
> +
> +        if (!err) {
> +            visit_check_struct(visitor, &err);
> +        }
> +        visit_end_struct(visitor, NULL);
> +        visit_free(visitor);
> +        if (err) {
> +            object_unref(obj);
> +            error_propagate(errp, err);
> +            return NULL;
> +        }
> +    }

The both >> if (err) << blocks could be extracted and moved at the end
of the function
to mark a 'cleanup section'  and both here and few lines before
(with the visit_start_struct failure) could use goto.
Easier to maintain and to make sure we make the proper cleanup in any case.

> +
> +    expansion_info = g_new0(CpuModelExpansionInfo, 1);
> +    expansion_info->model = g_malloc0(sizeof(*expansion_info->model));
> +    expansion_info->model->name = g_strdup(model->name);
> +
> +    qdict_out = qdict_new();
> +
> +    i = 0;
> +    while ((name = cpu_model_advertised_features[i++]) != NULL) {
> +        ObjectProperty *prop = object_property_find(obj, name, NULL);
> +        if (prop) {
> +            Error *err = NULL;
> +            QObject *value;
> +
> +            assert(prop->get);
> +            value = object_property_get_qobject(obj, name, &err);
> +            assert(!err);
> +
> +            qdict_put_obj(qdict_out, name, value);
> +        }
> +    }
> +

This could be merged with the first iteration over the features,
smth like:

    while () {
        if ((value = qdict_get(qdict_in, name))) {
            object_property_set ...
           if (!err)
               qobject_ref(value) /* we have the weak reference */
            else
                break;
        } else {
             value = object_property_get_qobject()
        }
        if (value) qdict_put_object(qdict_out, name, value)
    }

This way you iterate over the table once and you do not query
for the same property twice by getting the value from the qdict_in.
If the value is not acceptable we will fail either way so should be all good.


> +    if (!qdict_size(qdict_out)) {
> +        qobject_unref(qdict_out);
> +    } else {
> +        expansion_info->model->props = QOBJECT(qdict_out);
> +        expansion_info->model->has_props = true;
> +    }
> +
> +    object_unref(obj);
> +
> +    return expansion_info;

Mentioned earlier cleanup section:
cleanup:
   object_unref(obj);
   qobject_unref(qdict_out) ; /* if single loop is used */
   error_propagate(errp,err);
   return NULL;

> +}
> --
> 2.20.1
>

Hope I haven't missed anything.
What do you think ?

BR
Beata
> > Thanks,
> > drew

