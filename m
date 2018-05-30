Received: from eggs.gnu.org ([2001:4830:134:3::10]:43395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fNse4-00062f-BR
	for qemu-devel@nongnu.org; Wed, 30 May 2018 00:23:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fNse3-0001AU-HA
	for qemu-devel@nongnu.org; Wed, 30 May 2018 00:23:32 -0400
Date: Wed, 30 May 2018 00:23:22 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180530042322.GD9904@localhost.localdomain>
References: <20180529203910.7615-1-kwolf@redhat.com>
	<20180529203910.7615-6-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529203910.7615-6-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 05/16] qemu-iotests: Add
 VM.get_qmp_events_filtered()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

On Tue, May 29, 2018 at 10:38:59PM +0200, Kevin Wolf wrote:
> This adds a helper function that returns a list of QMP events that are
> already filtered through filter_qmp_event().
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Jeff Cody <jcody@redhat.com>

> ---
>  tests/qemu-iotests/iotests.py | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index 28159d837a..17aa7c88dc 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -383,6 +383,11 @@ class VM(qtest.QEMUQtestMachine):
>              output_list += [key + '=' + obj[key]]
>          return ','.join(output_list)
>  
> +    def get_qmp_events_filtered(self, wait=True):
> +        result = []
> +        for ev in self.get_qmp_events(wait=wait):
> +            result.append(filter_qmp_event(ev))
> +        return result
>  
>  
>  index_re = re.compile(r'([^\[]+)\[([^\]]+)\]')
> -- 
> 2.13.6
> 
