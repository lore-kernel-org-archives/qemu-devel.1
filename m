Received: from eggs.gnu.org ([2001:4830:134:3::10]:46590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dqGBI-0000ve-HX
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:06:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dqGB9-0004Mt-3M
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:06:36 -0400
Date: Fri, 8 Sep 2017 12:06:07 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170908100607.zpqygh66k5bpbhjd@eukaryote>
References: <20170904111616.21333-1-kchamart@redhat.com>
	<20170904125523.GC19748@lemon.lan>
	<20170904132859.cqj4ufphrvz2wsys@eukaryote>
	<46a46a9b-bb92-92cb-b4b1-2879467a7a5f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46a46a9b-bb92-92cb-b4b1-2879467a7a5f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: Make test 192 use QMP;
 convert it to Python
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, stefanha@redhat.com, kwolf@redhat.com, dgilbert@redhat.com

On Tue, Sep 05, 2017 at 02:37:21PM -0500, Eric Blake wrote:
> On 09/04/2017 08:28 AM, Kashyap Chamarthy wrote:
> > On Mon, Sep 04, 2017 at 08:55:23PM +0800, Fam Zheng wrote:
> >> Hi Kashyap,
> >>
> >> On Mon, 09/04 13:16, Kashyap Chamarthy wrote:
> 
> >>> The test 192 ("Test NBD export with '-incoming' (non-shared
> >>> storage migration use case from libvirt")) is currently using HMP.
> >>> Replace the HMP usage with QMP, as the upstream preference seems to be:
> >>> "Use QMP where possible, unless you're explicitly testing something
> >>> related to HMP".
> 
> Kevin actually argued that keeping some HMP coverage is a GOOD thing:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg00798.html

Yeah, noticed it after I sent my patch.  I agree with Kevin's argument,
so I'll just simply drop my patch.

> >> As an improvement maybe you could rebase to Stefan's "iotests: clean up
> >> resources using context managers" series and switch to "with" for the temp file
> >> and VM.
> > 
> > Good point.  I did notice that thread[*] about resource clean up.  And I
> > see it's already applied to 'block-next'.  Will rebase and change to the
> > 'with' statement.
> 
> I'm not sure if this patch helps us any; I personally find the unit-test
> style python iotests harder to debug than the ones that produce
> diff-able nnn.out files (debugging an nnn.out file that has only a list
> of ..... doesn't make it easy to reproduce).  If the test already runs
> well in shell, what does the conversion to Python actually buy us? 

While turning it to QMP, thought I'd convert it to Python as the test is
_very_ similar to 194 (also in Python).

Given Kevin's argument in the above thread you pointed out, just
disregard my patch.

-- 
/kashyap
