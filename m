Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C059C48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 16:35:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB943208E3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 16:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB943208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33930 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfoQ5-0000WD-9t
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 12:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43997)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hfo6x-0003ef-Q9
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 12:16:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hfo6w-00081c-E7
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 12:15:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52420)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hfo6w-0007m4-6J
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 12:15:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E6CE7C047B7A
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 16:15:38 +0000 (UTC)
Received: from redhat.com (ovpn-112-73.ams2.redhat.com [10.36.112.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 43F065D9C5;
 Tue, 25 Jun 2019 16:15:36 +0000 (UTC)
Date: Tue, 25 Jun 2019 17:15:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190625161533.GJ3139@redhat.com>
References: <20190625050008.12789-1-ehabkost@redhat.com>
 <20190625050008.12789-4-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190625050008.12789-4-ehabkost@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Tue, 25 Jun 2019 16:15:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/6] qmp: Add "alias-of" field to
 query-cpu-definitions
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 25, 2019 at 02:00:05AM -0300, Eduardo Habkost wrote:
> Management software will be expected to resolve CPU model name
> aliases using the new field.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/target.json | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/target.json b/qapi/target.json
> index 1d4d54b600..0197c7962c 100644
> --- a/qapi/target.json
> +++ b/qapi/target.json
> @@ -475,6 +475,12 @@
>  #            to introspect properties configurable using -cpu or -global.
>  #            (since 2.9)
>  #
> +# @alias-of: Name of CPU model this model is an alias for.  The target of the
> +#            CPU model alias may change depending on the machine type.
> +#            Management software is supposed to translate CPU model aliases
> +#            in the VM configuration, because aliases may stop being
> +#            migration-safe in the future (since 4.1)
> +#
>  # @unavailable-features is a list of QOM property names that
>  # represent CPU model attributes that prevent the CPU from running.
>  # If the QOM property is read-only, that means there's no known
> @@ -498,7 +504,8 @@
>              '*migration-safe': 'bool',
>              'static': 'bool',
>              '*unavailable-features': [ 'str' ],
> -            'typename': 'str' },
> +            'typename': 'str',
> +            '*alias-of' : 'str' },
>    'if': 'defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS)' }

IIUC, this means that data for a "Haswell" CPU model will now report
"alias-of": "Haswell-NNN"  (for some arbitrary NNN which may change
at will in any release).


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

