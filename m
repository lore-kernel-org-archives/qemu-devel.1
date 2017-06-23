Received: from eggs.gnu.org ([2001:4830:134:3::10]:60737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dOJkt-0007ZV-3w
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 04:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dOJkr-0004We-VF
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 04:15:51 -0400
Date: Fri, 23 Jun 2017 10:15:38 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170623081538.nqaxrylinzgg37il@eukaryote>
References: <1498040351-6376-2-git-send-email-kchamart@redhat.com>
	<bdbe5523-b066-a2ef-9e46-ece40ff4060d@redhat.com>
	<20170622085610.wasfoafo3b46iv4q@eukaryote>
	<3e638f0a-49f8-6fd0-04eb-12904768d571@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e638f0a-49f8-6fd0-04eb-12904768d571@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] live-block-ops.txt: Rename, rewrite,
 and improve it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, stephen@that.guru, armbru@redhat.com, mreitz@redhat.com

On Thu, Jun 22, 2017 at 10:13:03AM -0400, John Snow wrote:
> On 06/22/2017 04:56 AM, Kashyap Chamarthy wrote:
> > On Wed, Jun 21, 2017 at 06:49:02PM -0400, John Snow wrote:

[...]

> > Yes, I was thinking of this, too -- just link to the 'bitmaps' document.
> > 
> > A quick side question here: Since upstream QEMU is converging onto
> > Sphinx, and rST, hope you mind if I convert docs/devel/bitmaps.md into
> > rST at somepoint, for consistency's sake.  I'll file a separate review,
> > anyway for that.  In the long term, all / most other documents would
> > also be converted.
> > 
> 
> Of course not. I chose bitmaps.md so that it would be nice to view from
> the github interface while remaining nice to read in plaintext, but feel
> free to convert it if we actually do standardize on Sphinx/rST.
> 
> If you can make the generated output look prettier than the github
> rendering of the markdown I'll ACK it ;)

:-) Here's a sneak-peak (don't miss the index to your left hand side):

    https://kashyapc.fedorapeople.org/v3-QEMU-Docs/_build/html/docs/bitmaps.html

Compare that with the GitHub rendering:

    https://github.com/qemu/qemu/blob/master/docs/devel/bitmaps.md

And, here's the source (in reStructuredText, despite the ".txt"
extension) for the 'bitmaps' doc (I made tiny styling changes):

    https://kashyapc.fedorapeople.org/v3-QEMU-Docs/_build/html/_sources/docs/bitmaps.txt
    
> > Yes, I fully agree with your suggestion.  I will simply link to the
> > detailed document you wrote, which I was thinking of anyhow.
> > 
> > Thanks for your comments!
> > 
> Sure. You could perhaps mention the different sync modes, including top,
> none, full and incremental and urge readers to check out the bitmaps
> document for detailed workings of the incremental mode.

Yeah, good point.  I'll make that edit in v2.

-- 
/kashyap
