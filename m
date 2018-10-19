Received: from eggs.gnu.org ([2001:4830:134:3::10]:43789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDayE-0008V8-4Y
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 16:02:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDayD-0001m2-C7
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 16:02:06 -0400
Date: Fri, 19 Oct 2018 17:01:55 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181019200155.GJ31060@habkost.net>
References: <20181019191523.12157-1-mreitz@redhat.com>
	<20181019191523.12157-5-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019191523.12157-5-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/9] iotests: Use // for Python integer
 division
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>

On Fri, Oct 19, 2018 at 09:15:18PM +0200, Max Reitz wrote:
> In Python 3, / is always a floating-point division.  We usually do not
> want this, and as Python 2.7 understands // as well, change all integer
> divisions to use that.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
