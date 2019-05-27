Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17F5C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 18:16:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEC6220859
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 18:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC6220859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49149 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVKAT-0007kh-SQ
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 14:16:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hVK9i-0007Rw-E1
	for qemu-devel@nongnu.org; Mon, 27 May 2019 14:15:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hVK9h-0007yf-F0
	for qemu-devel@nongnu.org; Mon, 27 May 2019 14:15:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hVK9h-0007yI-8M
	for qemu-devel@nongnu.org; Mon, 27 May 2019 14:15:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 09E3C30842CE
	for <qemu-devel@nongnu.org>; Mon, 27 May 2019 18:15:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-250.ams2.redhat.com
	[10.36.117.250])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 84221608A6;
	Mon, 27 May 2019 18:15:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id EB6AC1138648; Mon, 27 May 2019 20:15:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
References: <1558079119-320634-1-git-send-email-imammedo@redhat.com>
	<1558079119-320634-3-git-send-email-imammedo@redhat.com>
Date: Mon, 27 May 2019 20:15:16 +0200
In-Reply-To: <1558079119-320634-3-git-send-email-imammedo@redhat.com> (Igor
	Mammedov's message of "Fri, 17 May 2019 09:45:15 +0200")
Message-ID: <8736kzix1n.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Mon, 27 May 2019 18:15:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 2/6] qmp: make "qom-list-properties"
 show initial property values
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: libvir-list@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
	qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Igor Mammedov <imammedo@redhat.com> writes:

> Add in the command output object's property values right after creation
> (i.e. state of the object returned by object_new() or equivalent).
>
> Follow up patch will add machine property 'numa-mem-supported', which
> would allow mgmt to introspect which machine types (versions) still
> support legacy "-numa mem=FOO" CLI option and which don't and require
> alternative '-numa memdev' option being used.

I'll have to study that patch to figure out what exactly the use case
is.

> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  qapi/misc.json | 5 ++++-
>  qmp.c          | 5 +++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 8b3ca4f..e333285 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -1365,10 +1365,13 @@
>  #
>  # @description: if specified, the description of the property.
>  #
> +# @default: initial property value.
> +#
>  # Since: 1.2
>  ##
>  { 'struct': 'ObjectPropertyInfo',
> -  'data': { 'name': 'str', 'type': 'str', '*description': 'str' } }
> +  'data': { 'name': 'str', 'type': 'str', '*description': 'str',
> +            '*default': 'any' } }

ObjectPropertyInfo has three users: qom-list, device-list-properties,
qom-list-properties.

>  
>  ##
>  # @qom-list:
> diff --git a/qmp.c b/qmp.c
> index b92d62c..8415541 100644
> --- a/qmp.c
> +++ b/qmp.c
> @@ -593,6 +593,11 @@ ObjectPropertyInfoList *qmp_qom_list_properties(const char *typename,
>          info->type = g_strdup(prop->type);
>          info->has_description = !!prop->description;
>          info->description = g_strdup(prop->description);
> +        if (obj) {
> +            info->q_default =
> +                object_property_get_qobject(obj, info->name, NULL);
> +            info->has_q_default = !!info->q_default;
> +        }
>  
>          entry = g_malloc0(sizeof(*entry));
>          entry->value = info;

You update only qom-list-properties.

The other two therefore never return objects with a @default member.
But query-qmp-schema can't tell.  Awkward.  The doc comments don't tell.
Doc bug.

You could have qom-list-properties return a new type

    { 'struct': 'ObjectPropertyInfoWithDefault',
      'base': 'ObjectPropertyInfo',
      'data': { '*default': any } }

The default value shown by qom-list-properties is the value found in a
fresh object created with object_new().  object_new() runs
->instance_init(), which can do anything.  When you call object_new()
again, you might find a different value.  In other words, the @default
returned by qom-list-properties is unreliable.

Related to this qom-list-properties caveat:

   # Note: objects can create properties at runtime, for example to describe
   # links between different devices and/or objects. These properties
   # are not included in the output of this command.

Please add a similar one for @default.

This command fights QOM's basic design premises, and it shows.

