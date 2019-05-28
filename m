Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5B2C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 13:15:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 675F32133F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 13:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675F32133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34928 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVbxA-0007Dw-Km
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 09:15:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hVbwM-0006kp-DU
	for qemu-devel@nongnu.org; Tue, 28 May 2019 09:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hVbwL-0006E8-8c
	for qemu-devel@nongnu.org; Tue, 28 May 2019 09:14:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13671)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hVbwL-0006BY-3N
	for qemu-devel@nongnu.org; Tue, 28 May 2019 09:14:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F1C63308402A
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 13:14:44 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5A09F78546;
	Tue, 28 May 2019 13:14:41 +0000 (UTC)
Date: Tue, 28 May 2019 15:14:37 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190528151437.5dab13d7@redhat.com>
In-Reply-To: <87woibhhdq.fsf@dusky.pond.sub.org>
References: <1558079119-320634-1-git-send-email-imammedo@redhat.com>
	<1558079119-320634-5-git-send-email-imammedo@redhat.com>
	<87woibhhdq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Tue, 28 May 2019 13:14:45 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 4/6] numa: introduce
 "numa-mem-supported" machine property
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

On Mon, 27 May 2019 20:38:57 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Igor Mammedov <imammedo@redhat.com> writes:
> 
> > '-numa mem' option has a number of issues and mgmt often defaults
> > to it. Unfortunately it's no possible to replace it with an alternative
> > '-numa memdev' without breaking migration compatibility.  
> 
> To be precise: -numa node,mem=... and -numa node,memdev=...  Correct?
yep, I'll try to use full syntax since so it would be clear to others.


> >                                                          What's possible
> > though is to deprecate it, keeping option working with old machine types.
> > Once deprecation period expires, QEMU will disable '-numa mem' option,
> > usage on new machine types and when the last machine type that supported
> > it is removed we would be able to remove '-numa mem' with associated code.
> >
> > In order to help mgmt to find out if being deprecated CLI option
> > '-numa mem=SZ' is still supported by particular machine type, expose
> > this information via "numa-mem-supported" machine property.
> >
> > Users can use "qom-list-properties" QMP command to list machine type
> > properties including initial proprety values (when probing for supported
> > machine types with '-machine none') or at runtime at preconfig time
> > before numa mapping is configured and decide if they should used legacy
> > '-numa mem' or alternative '-numa memdev' option.  
> 
> This sentence is impenetrable, I'm afraid :)
> 
> If we only want to convey whether a machine type supports -numa
> node,mem=..., then adding a flag to query-machines suffices.  Since I'm
> pretty sure you'd have figured that out yourself, I suspect I'm missing
I didn't know about query-machines, hence implemented "qom-list-properties"
approach as was discussed at https://www.mail-archive.com/qemu-devel@nongnu.org/msg601220.html

For the purpose of deprecating '-numa node,mem" query-machines is more than
enough. I'll drop 1-3 patches and respin series using query-machines.

> something.  Can you give me some examples of intended usage?
Perhaps there will in future use cases when introspecting 'defaults'
of objects will be needed, then we could look back into qom-list-properties
if there aren't a better alternative.


