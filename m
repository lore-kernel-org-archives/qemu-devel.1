Received: from eggs.gnu.org ([2001:4830:134:3::10]:44583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jdenemar@redhat.com>) id 1cHuy4-0003wZ-E7
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 11:02:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jdenemar@redhat.com>) id 1cHuy1-0000dt-Dh
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 11:02:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jdenemar@redhat.com>) id 1cHuy1-0000dW-7z
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 11:02:41 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DCF5D7F746
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 16:02:39 +0000 (UTC)
Date: Fri, 16 Dec 2016 17:02:36 +0100
From: Jiri Denemark <jdenemar@redhat.com>
Message-ID: <20161216160236.GA964730@orkuz.home>
References: <1480713496-11213-1-git-send-email-ehabkost@redhat.com>
	<1480713496-11213-16-git-send-email-ehabkost@redhat.com>
	<df0f3ade-bd09-58a0-ac83-3775d4ab7c6c@redhat.com>
	<20161205235745.GJ13060@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161205235745.GJ13060@thinpad.lan.raisama.net>
Subject: Re: [Qemu-devel] [PATCH for-2.9 15/17] target-i386: Define static
 "base" CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com

On Mon, Dec 05, 2016 at 21:57:45 -0200, Eduardo Habkost wrote:
> On Mon, Dec 05, 2016 at 07:18:47PM +0100, David Hildenbrand wrote:
> > Am 02.12.2016 um 22:18 schrieb Eduardo Habkost:
> > > The query-cpu-model-expand QMP command needs at least one static
> > > model, to allow the "static" expansion mode to be implemented.
> > > Instead of defining static versions of every CPU model, define a
> > > "base" CPU model that has absolutely no feature flag enabled.
> > > 
> > 
> > Introducing separate ones makes feature lists presented to the user much
> > shorter (and therefore easier to maintain). But I don't know how libvirt
> > wants to deal with models on x86 in the future.
> 
> I understand that having a larger set of static models would make
> expansions shorter. But I worry that by defining a complete set
> of static models on x86 would require extra maintenance work on
> the QEMU side with no visible benefit for libvirt.
> 
> I would like to hear from libvirt developers what they think. I
> still don't know what they plan to use the type=static expansion
> results for.

Currently we are mostly interested in the expansion of the "host" CPU
model. We're fine with the expansion based on the "basic" static model
with no features. Returning some real model instead of "basic" would be
OK as long as it would be one of the existing CPU models. Adding special
static models, such as Broadwell-base would actually be a complication
since we would need to provide some translation to the existing models
for backward compatibility. I'd appreciate if we could avoid doing this.

Jirka
