Received: from eggs.gnu.org ([2001:4830:134:3::10]:54753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gDfW2-0001jj-4b
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 20:53:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gDfW0-0006Br-NU
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 20:53:18 -0400
References: <20181019191523.12157-1-mreitz@redhat.com>
	<20181019191523.12157-6-mreitz@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <0714a34a-9182-d29e-4cd2-bff2d30c8c5d@redhat.com>
Date: Fri, 19 Oct 2018 20:53:08 -0400
MIME-Version: 1.0
In-Reply-To: <20181019191523.12157-6-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/9] iotests: Different iterator
 behavior in Python 3
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
> In Python 3, several functions now return iterators instead of lists.
> This includes range(), items(), map(), and filter().  This means that if
> we really want a list, we have to wrap those instances with list().  But
> then again, the two instances where this is the case for map() and
> filter(), there are shorter expressions which work without either
> function.
> 
> On the other hand, sometimes we do just want an iterator, in which case
> we have sometimes used xrange() and iteritems() which no longer exist in
> Python 3.  Just change these calls to be range() and items(), works in
> both Python 2 and 3, and is really what we want in 3 (which is what
> matters).  But because it is so simple to do (and to find and remove
> once we completely switch to Python 3), make range() be an alias for
> xrange() in the two affected tests (044 and 163).
> 
> In one instance, we only wanted the first instance of the result of a
> filter() call.  Instead of using next(filter()) which would work only in
> Python 3, or list(filter())[0] which would work everywhere but is a bit
> weird, this instance is changed to use list comprehension with a next()
> wrapped around, which works both in 2.7 and 3.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>
