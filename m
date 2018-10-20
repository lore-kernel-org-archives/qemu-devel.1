Received: from eggs.gnu.org ([2001:4830:134:3::10]:56296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gDfcR-0005bH-0f
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 20:59:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gDfcQ-0003nY-8m
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 20:59:54 -0400
References: <20181019191523.12157-1-mreitz@redhat.com>
	<20181019191523.12157-10-mreitz@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <782f456a-5981-0bb2-89c1-7cb5cec0bb6c@redhat.com>
Date: Fri, 19 Oct 2018 20:59:49 -0400
MIME-Version: 1.0
In-Reply-To: <20181019191523.12157-10-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 9/9] iotests: Unify log outputs between
 Python 2 and 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>



On 10/19/18 3:15 PM, Max Reitz wrote:
> When dumping an object into the log, there are differences between
> Python 2 and 3.  First, unicode strings are prefixed by 'u' in Python 2
> (they are no longer in 3, because unicode strings are the default
> there).  Second, the order of keys in dicts may differ.  Third,
> especially long numbers are longs in Python 2 and thus get an 'L'
> suffix, which does not happen in Python 3.
> 
> We can get around all of these differences by dumping objects (lists and
> dicts) in a language-independent format, namely JSON.  The JSON
> generator even allows emitting dicts with their keys sorted
> alphabetically.
> 
> This changes the output of all tests that use these logging functions
> (dict keys are ordered now, strings in dicts are now enclosed in double
> quotes instead of single quotes, the 'L' suffix of large integers is
> dropped, and "true" and "false" are now in lower case).
> The quote change necessitates a small change to a filter used in test
> 207.
> 
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>
