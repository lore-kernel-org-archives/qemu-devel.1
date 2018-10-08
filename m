Received: from eggs.gnu.org ([2001:4830:134:3::10]:56928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g9bNw-00057K-RX
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:40:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g9bNr-0001OY-SZ
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:40:08 -0400
References: <20181005234023.8104-1-mreitz@redhat.com>
	<20181005234023.8104-8-mreitz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <d3f8da86-f071-1ce0-462a-0b378f5214a9@redhat.com>
Date: Mon, 8 Oct 2018 15:34:55 -0400
MIME-Version: 1.0
In-Reply-To: <20181005234023.8104-8-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v11 07/31] iotests.py: Add
 node_info()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org



On 10/05/2018 07:39 PM, Max Reitz wrote:
> This function queries a node; since we cannot do that right now, it
> executes query-named-block-nodes and returns the matching node's object.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index 5c45788dac..604f200600 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -465,6 +465,13 @@ class VM(qtest.QEMUQtestMachine):
>                  else:
>                      iotests.log(ev)
>  
> +    def node_info(self, node_name):
> +        nodes = self.qmp('query-named-block-nodes')
> +        for x in nodes['return']:
> +            if x['node-name'] == node_name:
> +                return x
> +        return None
> +
>  
>  index_re = re.compile(r'([^\[]+)\[([^\]]+)\]')
>  
> 

Reviewed-by: John Snow <jsnow@redhat.com>

Do we ever want to revisit the idea that our API should not do any
pre-filtering and that it's always up to the client to do so?

--js
