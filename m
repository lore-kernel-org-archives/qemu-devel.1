Received: from eggs.gnu.org ([2001:4830:134:3::10]:56523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gDfdC-00064z-5W
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 21:00:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gDfdB-00052I-Ip
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 21:00:42 -0400
References: <20181019191523.12157-1-mreitz@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <70664aa1-4eda-5d00-608d-027cf472470e@redhat.com>
Date: Fri, 19 Oct 2018 21:00:34 -0400
MIME-Version: 1.0
In-Reply-To: <20181019191523.12157-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/9] iotests: Make them work for both
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
> This series prepares the iotests to work with both Python 2 and 3.  In
> some places, it adds version-specific code and decides what to do based
> on the version (for instance, whether to import the StringIO or the
> BytesIO class from 'io' for use with the test runner), but most of the
> time, it just makes code work for both versions in general.
> 

Tested on both Python 2 and 3.

Tested-by: Cleber Rosa <crosa@redhat.com>
