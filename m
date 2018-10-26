Received: from eggs.gnu.org ([2001:4830:134:3::10]:39168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFxtC-0002Z1-0a
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 04:54:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFxtB-0004mc-Bv
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 04:54:41 -0400
Date: Fri, 26 Oct 2018 05:54:33 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181026085433.GN4096@habkost.net>
References: <20181022135307.14398-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022135307.14398-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/9] iotests: Make them work for both
 Python 2 and 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Mon, Oct 22, 2018 at 02:52:58PM +0100, Max Reitz wrote:
> This series prepares the iotests to work with both Python 2 and 3.  In
> some places, it adds version-specific code and decides what to do based
> on the version (for instance, whether to import the StringIO or the
> BytesIO class from 'io' for use with the test runner), but most of the
> time, it just makes code work for both versions in general.
> 
> And when we make the switch to make Python 3 mandatory, we can simply
> drop the Python 2 branches.

Queued on python-next, thanks!

-- 
Eduardo
