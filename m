Received: from eggs.gnu.org ([2001:4830:134:3::10]:57748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOuN6-0006e5-OP
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 20:26:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOuN6-0003yD-1f
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 20:26:16 -0400
References: <20180417153945.20737-1-pbonzini@redhat.com>
	<20180417153945.20737-4-pbonzini@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <06f1f4ea-4d82-cbfa-ce8a-4f5198cd2031@redhat.com>
Date: Fri, 1 Jun 2018 20:26:10 -0400
MIME-Version: 1.0
In-Reply-To: <20180417153945.20737-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/6] ide: call ide_cmd_done from
 ide_transfer_stop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org



On 04/17/2018 11:39 AM, Paolo Bonzini wrote:
> The code can simply be moved to the sole caller that has notify == true.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>
