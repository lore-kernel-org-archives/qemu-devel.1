Received: from eggs.gnu.org ([2001:4830:134:3::10]:48569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gDezc-0001yT-Ou
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 20:19:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gDezc-00039D-4y
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 20:19:48 -0400
References: <20181019191523.12157-1-mreitz@redhat.com>
	<20181019191523.12157-5-mreitz@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <19756270-c1f7-bd24-fab6-d30c719da5d3@redhat.com>
Date: Fri, 19 Oct 2018 20:19:27 -0400
MIME-Version: 1.0
In-Reply-To: <20181019191523.12157-5-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>



On 10/19/18 3:15 PM, Max Reitz wrote:
> In Python 3, / is always a floating-point division.  We usually do not
> want this, and as Python 2.7 understands // as well, change all integer
> divisions to use that.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>
