Received: from eggs.gnu.org ([2001:4830:134:3::10]:46448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fJ0yT-0004UD-V3
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:16:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fJ0yQ-0007y0-P3
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:16:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fJ0yQ-0007xq-K6
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:16:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D2B8111BB77
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 18:16:25 +0000 (UTC)
Date: Wed, 16 May 2018 15:16:24 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180516181624.GG4903@localhost.localdomain>
References: <1525423069-61903-1-git-send-email-imammedo@redhat.com>
	<1525423069-61903-7-git-send-email-imammedo@redhat.com>
	<44a24950-bb9d-09a9-a8ae-31f0d9c96d77@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <44a24950-bb9d-09a9-a8ae-31f0d9c96d77@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 06/11] tests: qapi-schema tests for
 allow-preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, pkrempa@redhat.com, armbru@redhat.com

On Fri, May 11, 2018 at 10:29:00AM -0500, Eric Blake wrote:
> On 05/04/2018 03:37 AM, Igor Mammedov wrote:
> > use new allow-preconfig parameter in tests and make sure that
> > the QAPISchema can parse allow-preconfig correctly
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > v7:
> 
> Missing --- separator to stop 'git am' from including the changelog.

Fixed while applying.

> 
> >    * s/allowed_in_preconfig/allow_preconfig/
> >    * squash in "tests: add allow-preconfig-test for qapi-schema"
> >    * reuse an-oob-command for allow-preconfig test and rename it to test-flags-command
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>

Queued, thanks.

-- 
Eduardo
