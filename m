Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F418C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:06:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2526E21479
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2526E21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43284 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSrMU-0005ra-Az
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 19:06:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hSrKx-00052e-36
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:04:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hSrKv-0005Ep-9I
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:04:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hSrKu-0005Di-Vb
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:04:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3B20759467;
	Mon, 20 May 2019 23:04:52 +0000 (UTC)
Received: from localhost (ovpn-116-14.gru2.redhat.com [10.97.116.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A796F60BE2;
	Mon, 20 May 2019 23:04:49 +0000 (UTC)
Date: Mon, 20 May 2019 20:04:47 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: John Snow <jsnow@redhat.com>
Message-ID: <20190520230447.GH10764@habkost.net>
References: <8c0a113e959cc2419aa52253c261e111ac9caf4a.camel@gmail.com>
	<81b5a062-2bb5-8b2f-6a33-1f886211fc09@redhat.com>
	<58d6c6ea-cf6e-d6d4-0605-dee933acf0f1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58d6c6ea-cf6e-d6d4-0605-dee933acf0f1@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Mon, 20 May 2019 23:04:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] QMP Example Formatting in ReST, Sphinx,
 and Pygments (was: Re:  [Bug] Docs build fails at interop.rst)
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
Cc: Gabriel Barreto <sbarreto.gabriel@gmail.com>,
	Aarushi Mehta <mehta.aaru20@gmail.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 20, 2019 at 05:25:28PM -0400, John Snow wrote:
> 
> 
> On 5/20/19 12:37 PM, John Snow wrote:
> > 
> > 
> > On 5/20/19 7:30 AM, Aarushi Mehta wrote:
> >> https://paste.fedoraproject.org/paste/kOPx4jhtUli---TmxSLrlw
> >> running python3-sphinx-2.0.1-1.fc31.noarch on Fedora release 31
> >> (Rawhide)
> >>
> >> uname - a
> >> Linux iouring 5.1.0-0.rc6.git3.1.fc31.x86_64 #1 SMP Thu Apr 25 14:25:32
> >> UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
> >>
> >> Reverting commmit 90edef80a0852cf8a3d2668898ee40e8970e431
> >> allows for the build to occur
> >>
> >> Regards
> >> Aarushi Mehta
> >>
> >>
> > 
> > Ah, dang. The blocks aren't strictly conforming json, but the version I
> > tested this under didn't seem to care. Your version is much newer. (I
> > was using 1.7 as provided by Fedora 29.)
> > 
> > For now, try reverting 9e5b6cb87db66dfb606604fe6cf40e5ddf1ef0e7 instead,
> > which should at least turn off the "warnings as errors" option, but I
> > don't think that reverting -n will turn off this warning.
> > 
> > I'll try to get ahold of this newer version and see if I can't fix it
> > more appropriately.
> > 
> > --js
> > 
> 
> ...Sigh, okay.
> 
> So, I am still not actually sure what changed from pygments 2.2 and
> sphinx 1.7 to pygments 2.4 and sphinx 2.0.1, but it appears as if Sphinx
> by default always tries to do add a filter to the pygments lexer that
> raises an error on highlighting failure, instead of the default behavior
> which is to just highlight those errors in the output. There is no
> option to Sphinx that I am aware of to retain this lexing behavior.
> (Effectively, it's strict or nothing.)
> 
> This approach, apparently, is broken in Sphinx 1.7/Pygments 2.2, so the
> build works with our malformed json.
> 
> There are a few options:
> 
> 1. Update conf.py to ignore these warnings (and all future lexing
> errors), and settle for the fact that there will be no QMP highlighting
> wherever we use the directionality indicators ('->', '<-').
> 
> 2. Update bitmaps.rst to remove the directionality indicators.
> 
> 3. Update bitmaps.rst to format the QMP blocks as raw text instead of JSON.
> 
> 4. Update bitmaps.rst to remove the "json" specification from the code
> block. This will cause sphinx to "guess" the formatting, and the
> pygments guesser will decide it's Python3.
> 
> This will parse well enough, but will mis-highlight 'true' and 'false'
> which are not python keywords. This approach may break in the future if
> the Python3 lexer is upgraded to be stricter (because '->' and '<-' are
> still invalid), and leaves us at the mercy of both the guesser and the
> lexer.
> 
> I'm not actually sure what I dislike the least; I think I dislike #1 the
> most. #4 gets us most of what we want but is perhaps porcelain.
> 
> I suspect if we attempt to move more of our documentation to ReST and
> Sphinx that we will need to answer for ourselves how we intend to
> document QMP code flow examples.

Writing a custom lexer that handles "<-" and "->" was simple (see below).

Now, is it possible to convince Sphinx to register and use a custom lexer?

$ cat > /tmp/lexer.py <<EOF
from pygments.lexer import RegexLexer, DelegatingLexer
from pygments.lexers.data import JsonLexer
import re
from pygments.token import *

class QMPExampleMarkersLexer(RegexLexer):
    tokens = {
        'root': [
            (r' *-> *', Generic.Prompt),
            (r' *<- *', Generic.Output),
        ]
    }

class QMPExampleLexer(DelegatingLexer):
    def __init__(self, **options):
        super(QMPExampleLexer, self).__init__(JsonLexer, QMPExampleMarkersLexer, Error, **options)
EOF
$ pygmentize -l /tmp/lexer.py:QMPExampleLexer -x -f html <<EOF
    -> {
         "execute": "drive-backup",
         "arguments": {
           "device": "drive0",
           "bitmap": "bitmap0",
           "target": "drive0.inc0.qcow2",
           "format": "qcow2",
           "sync": "incremental",
           "mode": "existing"
         }
       }

    <- { "return": {} }
EOF
<div class="highlight"><pre><span></span><span class="gp">    -&gt; </span><span class="p">{</span>
         <span class="nt">&quot;execute&quot;</span><span class="p">:</span> <span class="s2">&quot;drive-backup&quot;</span><span class="p">,</span>
         <span class="nt">&quot;arguments&quot;</span><span class="p">:</span> <span class="p">{</span>
           <span class="nt">&quot;device&quot;</span><span class="p">:</span> <span class="s2">&quot;drive0&quot;</span><span class="p">,</span>
           <span class="nt">&quot;bitmap&quot;</span><span class="p">:</span> <span class="s2">&quot;bitmap0&quot;</span><span class="p">,</span>
           <span class="nt">&quot;target&quot;</span><span class="p">:</span> <span class="s2">&quot;drive0.inc0.qcow2&quot;</span><span class="p">,</span>
           <span class="nt">&quot;format&quot;</span><span class="p">:</span> <span class="s2">&quot;qcow2&quot;</span><span class="p">,</span>
           <span class="nt">&quot;sync&quot;</span><span class="p">:</span> <span class="s2">&quot;incremental&quot;</span><span class="p">,</span>
           <span class="nt">&quot;mode&quot;</span><span class="p">:</span> <span class="s2">&quot;existing&quot;</span>
         <span class="p">}</span>
       <span class="p">}</span>

<span class="go">    &lt;- </span><span class="p">{</span> <span class="nt">&quot;return&quot;</span><span class="p">:</span> <span class="p">{}</span> <span class="p">}</span>
</pre></div>
$ 


-- 
Eduardo

