Received: from eggs.gnu.org ([2001:4830:134:3::10]:56040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gDfbH-0004zT-Uf
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 20:58:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gDfbH-0002h1-6F
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 20:58:43 -0400
References: <20181019191523.12157-1-mreitz@redhat.com>
	<20181019191523.12157-9-mreitz@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <048c781d-a330-2aee-e85c-761539e10fd9@redhat.com>
Date: Fri, 19 Oct 2018 20:58:33 -0400
MIME-Version: 1.0
In-Reply-To: <20181019191523.12157-9-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 8/9] iotests: Modify imports for Python 3
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
> There are two imports that need to be modified when running the iotests
> under Python 3: One is StringIO, which no longer exists; instead, the
> StringIO class comes from the io module, so import it from there (and
> use the BytesIO class for Python 2).  The other is the ConfigParser,
> which has just been renamed to configparser.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>
