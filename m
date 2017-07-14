Received: from eggs.gnu.org ([2001:4830:134:3::10]:35980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dW4Bv-0001aa-EW
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 13:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dW4Bq-0005j9-HC
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 13:15:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dW4Bq-0005iZ-7i
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 13:15:42 -0400
Date: Fri, 14 Jul 2017 14:15:36 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170714171536.GL6020@localhost.localdomain>
References: <1500025208-14827-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1500025208-14827-2-git-send-email-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1500025208-14827-2-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCHv9 1/3] fw_cfg: switch fw_cfg_find() to
 locate the fw_cfg device by type rather than path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, lersek@redhat.com, somlo@cmu.edu, mst@redhat.com, pbonzini@redhat.com, rjones@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org

On Fri, Jul 14, 2017 at 10:40:06AM +0100, Mark Cave-Ayland wrote:
> This will enable the fw_cfg device to be placed anywhere within the QOM tree
> regardless of its machine location.
> 
> Note that we also add a comment to document the behaviour that we return NULL to
> indicate failure where either no fw_cfg device or multiple fw_cfg devices are
> found.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
