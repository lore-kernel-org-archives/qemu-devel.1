Received: from eggs.gnu.org ([2001:4830:134:3::10]:47444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eXWFs-0001Z8-Et
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 12:58:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eXWFm-0005aa-QO
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 12:58:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eXWFm-0005ZT-FH
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 12:58:02 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 10AAD7E426
	for <qemu-devel@nongnu.org>; Fri,  5 Jan 2018 17:58:01 +0000 (UTC)
Date: Fri, 5 Jan 2018 17:57:54 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180105175753.GB2490@work-vm>
References: <1513370232-25515-1-git-send-email-wei@redhat.com>
	<87po6pz8pg.fsf@secure.laptop>
	<c11296c9-29aa-0401-dc65-76c5ef2eea08@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c11296c9-29aa-0401-dc65-76c5ef2eea08@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 1/1] tests: Add migration test for
 aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Huang <wei@redhat.com>
Cc: quintela@redhat.com, Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org

* Wei Huang (wei@redhat.com) wrote:
> 
> 
> On 01/04/2018 02:10 PM, Juan Quintela wrote:
> > Wei Huang <wei@redhat.com> wrote:
> > But once that everybody is looking, I would like to open a discussion
> > about how to make more abstract this test, and not adding so many bits
> > each time that we need to create a new machine.
> 
> The test cases themselves are the most annoying ones. x86/aarch64 use
> assembly (converted to binaries); but ppc uses scripts. How to find a
> common solution to suite all arch's?

The asm/binaries is the main issue since reading/editing the binary is
horrible. Power's forth is tiny and almost readable.  If we want we could
move it into a separate .c file somewhere just as a string but tat's
a minor issue.

Dave

> > 
> > And once that we are here, I *think* that the ppc test is wrong, it is
> > missing the -drive-file on destination, no?
> 
> [cc'ing Laurent]
> 
> > 
> > And once here, does -cpu host make sense only for arm, or should we do
> > it for all archs?
> 
> I think x86 and aarch64 are OK with it. But I am not sure about PPC.
> 
> > 
> > Thanks, Juan.
> > 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
