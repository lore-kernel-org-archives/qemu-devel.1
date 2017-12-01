Received: from eggs.gnu.org ([2001:4830:134:3::10]:45061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eKnVg-0007rV-Ih
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:46:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eKnUE-0004Ov-W9
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:45:52 -0500
Date: Fri, 1 Dec 2017 09:33:08 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171201013308.GA31109@lemon>
References: <20171123020832.8165-1-mreitz@redhat.com>
	<20171123020832.8165-7-mreitz@redhat.com>
	<20171130031646.GK16237@lemon>
	<3e80f97a-625d-86ae-db94-6f2f1d804a93@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e80f97a-625d-86ae-db94-6f2f1d804a93@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/17] iotests: Drop format-specific in
 _filter_img_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Thu, 11/30 09:42, Eric Blake wrote:
> On 11/29/2017 09:16 PM, Fam Zheng wrote:
> > On Thu, 11/23 03:08, Max Reitz wrote:
> > > _filter_img_info should remove format-specific information, too.  We
> > > already have such a filter in _img_info, and it is very useful for
> > > query-block-named-block-nodes (etc.), too.
> > > 
> > > However, in 198 we need that information (but we still want the rest of
> > > the filter), so make that filtering optional.  Note that "the rest of
> > > the filter" includes filtering of the test directory, so we can drop the
> > > _filter_testdir from 198 at the same time.
> > > 
> 
> > > +        if [[ $discard == 0 ]]; then
> > > +            echo "$line"
> > > +        elif [[ $discard == 1 && ! $line ]]; then
> > 
> > s/\$line/"\$line"/ ?
> > 
> 
> Not necessary; [[ ]] is a bashism, which is part of the shell grammar so it
> doesn't need quoting.  In fact, there are some expressions in [[ ]] where
> comparing to "$foo" is actively different than comparing to $foo (mostly in
> regex, as the quotes change whether \ inside $foo are special to the regex
> or literally matched).
> 
> So this part is fine.

Interesting.. Thank you!

Reviewed-by: Fam Zheng <famz@redhat.com>
