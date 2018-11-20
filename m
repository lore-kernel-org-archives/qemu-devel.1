Received: from eggs.gnu.org ([2001:4830:134:3::10]:37976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gPDie-0001Ir-14
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 16:38:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gPDid-0005ep-5I
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 16:38:03 -0500
References: <20181120172252.17800-1-kwolf@redhat.com>
	<20181120172252.17800-3-kwolf@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <c96bff11-d143-c3ea-adc9-7cb6b6431984@redhat.com>
Date: Tue, 20 Nov 2018 16:37:52 -0500
MIME-Version: 1.0
In-Reply-To: <20181120172252.17800-3-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/2] iotests: Replace
 assertEquals() with assertEqual()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com



On 11/20/18 12:22 PM, Kevin Wolf wrote:
> TestCase.assertEquals() is deprecated since Python 2.7. Recent Python
> versions print a warning when the function is called, which makes test
> cases fail.
> 
> Replace it with the preferred spelling assertEqual().
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>
