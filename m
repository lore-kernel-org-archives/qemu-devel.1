Received: from eggs.gnu.org ([209.51.188.92]:41011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gttqW-000083-A8
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 07:41:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gttqI-00080O-E2
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 07:40:50 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gttqC-0007u1-4e
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 07:40:41 -0500
Received: by mail-wr1-f66.google.com with SMTP id l5so1240747wrw.6
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 04:40:37 -0800 (PST)
References: <20190213065357.16076-1-yuval.shaia@oracle.com>
	<20190213065357.16076-9-yuval.shaia@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d460be76-ceb9-16ba-6cc7-56541a420753@redhat.com>
Date: Wed, 13 Feb 2019 13:40:34 +0100
MIME-Version: 1.0
In-Reply-To: <20190213065357.16076-9-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 7/9] hw/pvrdma: Delete unneeded function
 argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>
Cc: Yuval Shaia <yuval.shaia@oracle.com>, dgilbert@redhat.com, armbru@redhat.com

On 2/13/19 7:53 AM, Yuval Shaia wrote:
> The function argument rdma_dev_res is not needed as it is stored in the
> backend_dev object at init.
> 
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Should we teach checkpatch.pl to check name/space/email?
