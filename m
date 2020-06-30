Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F0DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:53:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BEEC20829
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BEEC20829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqGhQ-0008Vp-Kj
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 09:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jqGWg-0005Y9-E7
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 09:42:18 -0400
Received: from 10.mo7.mail-out.ovh.net ([178.33.250.56]:50606)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jqGWc-0006vk-Sb
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 09:42:18 -0400
Received: from player698.ha.ovh.net (unknown [10.110.103.41])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id BB16816C2A1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 15:42:03 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player698.ha.ovh.net (Postfix) with ESMTPSA id 7D10A13E00767;
 Tue, 30 Jun 2020 13:41:54 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R0066526ca7b-8267-4449-9bf9-375ecf278710,321FFE8278D843C460097280AF09A0BF63DC926D)
 smtp.auth=groug@kaod.org
Date: Tue, 30 Jun 2020 15:41:51 +0200
From: Greg Kurz <groug@kaod.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v5 1/3] qom: Introduce object_property_try_add_child()
Message-ID: <20200630154151.229e60eb@bahia.lan>
In-Reply-To: <20200629193424.30280-2-eric.auger@redhat.com>
References: <20200629193424.30280-1-eric.auger@redhat.com>
 <20200629193424.30280-2-eric.auger@redhat.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 4695847038586362218
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrtddtgdefkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeehkefhtdehgeehheejledufeekhfdvleefvdeihefhkefhudffhfeuuedvffdthfenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieelkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=178.33.250.56; envelope-from=groug@kaod.org;
 helo=10.mo7.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 09:42:04
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: berrange@redhat.com, ehabkost@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 29 Jun 2020 21:34:22 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> object_property_add() does not allow object_property_try_add()
> to gracefully fail as &error_abort is passed as an error handle.
> 
> However such failure can easily be triggered from the QMP shell when,
> for instance, one attempts to create an object with an id that already
> exists. This is achieved from the following call path:
> 
> qmp_object_add -> user_creatable_add_dict -> user_creatable_add_type ->
> object_property_add_child -> object_property_add
> 
> For instance, from the qmp-shell, call twice:
> object-add qom-type=memory-backend-ram id=mem1 props.size=1073741824
> and QEMU aborts.
> 
> This behavior is undesired as a user/management application mistake
> in reusing a property ID shouldn't result in loss of the VM and live
> data within.
> 
> This patch introduces a new function, object_property_try_add_child()
> which takes an error handle and turn object_property_try_add() into
> a non-static one.
> 
> Now the call path becomes:
> 
> user_creatable_add_type -> object_property_try_add_child ->
> object_property_try_add
> 
> and the error is returned gracefully to the QMP client.
> 
> (QEMU) object-add qom-type=memory-backend-ram id=mem2  props.size=4294967296
> {"return": {}}
> (QEMU) object-add qom-type=memory-backend-ram id=mem2  props.size=4294967296
> {"error": {"class": "GenericError", "desc": "attempt to add duplicate property
> 'mem2' to object (type 'container')"}}
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Fixes: d2623129a7de ("qom: Drop parameter @errp of object_property_add() & friends")
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 

FWIW

Reviewed-by: Greg Kurz <groug@kaod.org>

and

Tested-by: Greg Kurz <groug@kaod.org>

> ---
> 
> v3 -> v4:
> - Took into account Markus' style related comments
> 
> v2 -> v3:
> - don't take the object reference on failure in
>   object_property_try_add_child
> ---
>  include/qom/object.h    | 26 ++++++++++++++++++++++++--
>  qom/object.c            | 21 ++++++++++++++++-----
>  qom/object_interfaces.c |  7 +++++--
>  3 files changed, 45 insertions(+), 9 deletions(-)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 94a61ccc3f..1c5cdcd0e3 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1039,7 +1039,7 @@ Object *object_ref(Object *obj);
>  void object_unref(Object *obj);
>  
>  /**
> - * object_property_add:
> + * object_property_try_add:
>   * @obj: the object to add a property to
>   * @name: the name of the property.  This can contain any character except for
>   *  a forward slash.  In general, you should use hyphens '-' instead of
> @@ -1056,10 +1056,23 @@ void object_unref(Object *obj);
>   *   meant to allow a property to free its opaque upon object
>   *   destruction.  This may be NULL.
>   * @opaque: an opaque pointer to pass to the callbacks for the property
> + * @errp: pointer to error object
>   *
>   * Returns: The #ObjectProperty; this can be used to set the @resolve
>   * callback for child and link properties.
>   */
> +ObjectProperty *object_property_try_add(Object *obj, const char *name,
> +                                        const char *type,
> +                                        ObjectPropertyAccessor *get,
> +                                        ObjectPropertyAccessor *set,
> +                                        ObjectPropertyRelease *release,
> +                                        void *opaque, Error **errp);
> +
> +/**
> + * object_property_add:
> + * Same as object_property_try_add() with @errp hardcoded to
> + * &error_abort.
> + */
>  ObjectProperty *object_property_add(Object *obj, const char *name,
>                                      const char *type,
>                                      ObjectPropertyAccessor *get,
> @@ -1495,10 +1508,11 @@ Object *object_resolve_path_type(const char *path, const char *typename,
>  Object *object_resolve_path_component(Object *parent, const char *part);
>  
>  /**
> - * object_property_add_child:
> + * object_property_try_add_child:
>   * @obj: the object to add a property to
>   * @name: the name of the property
>   * @child: the child object
> + * @errp: pointer to error object
>   *
>   * Child properties form the composition tree.  All objects need to be a child
>   * of another object.  Objects can only be a child of one object.
> @@ -1512,6 +1526,14 @@ Object *object_resolve_path_component(Object *parent, const char *part);
>   *
>   * Returns: The newly added property on success, or %NULL on failure.
>   */
> +ObjectProperty *object_property_try_add_child(Object *obj, const char *name,
> +                                              Object *child, Error **errp);
> +
> +/**
> + * object_property_add_child:
> + * Same as object_property_try_add_child() with @errp hardcoded to
> + * &error_abort
> + */
>  ObjectProperty *object_property_add_child(Object *obj, const char *name,
>                                            Object *child);
>  
> diff --git a/qom/object.c b/qom/object.c
> index 6ece96bc2b..dc10bb1889 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1132,7 +1132,7 @@ void object_unref(Object *obj)
>      }
>  }
>  
> -static ObjectProperty *
> +ObjectProperty *
>  object_property_try_add(Object *obj, const char *name, const char *type,
>                          ObjectPropertyAccessor *get,
>                          ObjectPropertyAccessor *set,
> @@ -1651,8 +1651,8 @@ static void object_finalize_child_property(Object *obj, const char *name,
>  }
>  
>  ObjectProperty *
> -object_property_add_child(Object *obj, const char *name,
> -                          Object *child)
> +object_property_try_add_child(Object *obj, const char *name,
> +                              Object *child, Error **errp)
>  {
>      g_autofree char *type = NULL;
>      ObjectProperty *op;
> @@ -1661,14 +1661,25 @@ object_property_add_child(Object *obj, const char *name,
>  
>      type = g_strdup_printf("child<%s>", object_get_typename(child));
>  
> -    op = object_property_add(obj, name, type, object_get_child_property, NULL,
> -                             object_finalize_child_property, child);
> +    op = object_property_try_add(obj, name, type, object_get_child_property,
> +                                 NULL, object_finalize_child_property,
> +                                 child, errp);
> +    if (!op) {
> +        return NULL;
> +    }
>      op->resolve = object_resolve_child_property;
>      object_ref(child);
>      child->parent = obj;
>      return op;
>  }
>  
> +ObjectProperty *
> +object_property_add_child(Object *obj, const char *name,
> +                          Object *child)
> +{
> +    return object_property_try_add_child(obj, name, child, &error_abort);
> +}
> +
>  void object_property_allow_set_link(const Object *obj, const char *name,
>                                      Object *val, Error **errp)
>  {
> diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> index 7e26f86fa6..1e05e41d2f 100644
> --- a/qom/object_interfaces.c
> +++ b/qom/object_interfaces.c
> @@ -82,8 +82,11 @@ Object *user_creatable_add_type(const char *type, const char *id,
>      }
>  
>      if (id != NULL) {
> -        object_property_add_child(object_get_objects_root(),
> -                                  id, obj);
> +        object_property_try_add_child(object_get_objects_root(),
> +                                      id, obj, &local_err);
> +        if (local_err) {
> +            goto out;
> +        }
>      }
>  
>      user_creatable_complete(USER_CREATABLE(obj), &local_err);


