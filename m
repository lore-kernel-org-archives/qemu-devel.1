Received: from eggs.gnu.org ([2001:4830:134:3::10]:47797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqlnN-0003uD-Rj
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:24:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqlnN-0003F8-1d
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:24:17 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-22-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3dfe950d-6e46-fc41-d91a-3a6c4a6a4df1@redhat.com>
Date: Tue, 27 Feb 2018 14:24:10 -0600
MIME-Version: 1.0
In-Reply-To: <20180223235142.21501-22-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 21/21] blockjobs: add manual_mgmt option
 to transactions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org

On 02/23/2018 05:51 PM, John Snow wrote:
> This allows us to easily force the option for all jobs belonging
> to a transaction to ensure consistency with how all those jobs
> will be handled.
> 
> This is purely a convenience.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---

> +++ b/qapi/transaction.json
> @@ -79,7 +79,8 @@
>   ##
>   { 'struct': 'TransactionProperties',
>     'data': {
> -       '*completion-mode': 'ActionCompletionMode'
> +       '*completion-mode': 'ActionCompletionMode',
> +       '*manual-mgmt': 'bool'

Missing QAPI documentation (what you have elsewhere in the C code can 
probably be copied here, though).

The UI aspect makes sense (I can declare one manual at the transaction 
level instead of multiple manual declarations per member level within 
the transaction).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
