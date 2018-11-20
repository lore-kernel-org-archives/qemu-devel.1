Received: from eggs.gnu.org ([2001:4830:134:3::10]:37151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPCTD-0002lV-9F
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:18:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPCTA-0006yb-Ih
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:18:03 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gPCTA-0006wo-Am
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:18:00 -0500
Received: by mail-wm1-f68.google.com with SMTP id k198so3587802wmd.3
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 12:18:00 -0800 (PST)
References: <20181120172252.17800-1-kwolf@redhat.com>
	<20181120172252.17800-3-kwolf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4e2d1505-c5f6-fd8f-38fe-a4cd1457f352@redhat.com>
Date: Tue, 20 Nov 2018 21:17:58 +0100
MIME-Version: 1.0
In-Reply-To: <20181120172252.17800-3-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] iotests: Replace assertEquals() with
 assertEqual()
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

On 20/11/18 18:22, Kevin Wolf wrote:
> TestCase.assertEquals() is deprecated since Python 2.7. Recent Python
> versions print a warning when the function is called, which makes test
> cases fail.
> 
> Replace it with the preferred spelling assertEqual().
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   tests/qemu-iotests/041        | 6 +++---
>   tests/qemu-iotests/118        | 4 ++--
>   tests/qemu-iotests/iotests.py | 2 +-
>   3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
> index 3615011d98..26bf1701eb 100755
> --- a/tests/qemu-iotests/041
> +++ b/tests/qemu-iotests/041
> @@ -469,7 +469,7 @@ new_state = "1"
>               self.assert_qmp(event, 'data/id', 'drive0')
>               event = self.vm.get_qmp_event(wait=True)
>   
> -        self.assertEquals(event['event'], 'BLOCK_JOB_ERROR')
> +        self.assertEqual(event['event'], 'BLOCK_JOB_ERROR')
>           self.assert_qmp(event, 'data/device', 'drive0')
>           self.assert_qmp(event, 'data/operation', 'read')
>           result = self.vm.qmp('query-block-jobs')
> @@ -494,7 +494,7 @@ new_state = "1"
>               self.assert_qmp(event, 'data/id', 'drive0')
>               event = self.vm.get_qmp_event(wait=True)
>   
> -        self.assertEquals(event['event'], 'BLOCK_JOB_ERROR')
> +        self.assertEqual(event['event'], 'BLOCK_JOB_ERROR')
>           self.assert_qmp(event, 'data/device', 'drive0')
>           self.assert_qmp(event, 'data/operation', 'read')
>           result = self.vm.qmp('query-block-jobs')
> @@ -625,7 +625,7 @@ new_state = "1"
>           self.assert_qmp(result, 'return', {})
>   
>           event = self.vm.event_wait(name='BLOCK_JOB_ERROR')
> -        self.assertEquals(event['event'], 'BLOCK_JOB_ERROR')
> +        self.assertEqual(event['event'], 'BLOCK_JOB_ERROR')
>           self.assert_qmp(event, 'data/device', 'drive0')
>           self.assert_qmp(event, 'data/operation', 'write')
>           result = self.vm.qmp('query-block-jobs')
> diff --git a/tests/qemu-iotests/118 b/tests/qemu-iotests/118
> index c4f4c213ca..603e10e8a2 100755
> --- a/tests/qemu-iotests/118
> +++ b/tests/qemu-iotests/118
> @@ -261,7 +261,7 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
>           result = self.vm.qmp('blockdev-close-tray', id=self.device_name)
>           # Should be a no-op
>           self.assert_qmp(result, 'return', {})
> -        self.assertEquals(self.vm.get_qmp_events(wait=False), [])
> +        self.assertEqual(self.vm.get_qmp_events(wait=False), [])
>   
>       def test_remove_on_closed(self):
>           if not self.has_real_tray:
> @@ -448,7 +448,7 @@ class TestChangeReadOnly(ChangeBaseClass):
>                                                          read_only_mode='retain')
>           self.assert_qmp(result, 'error/class', 'GenericError')
>   
> -        self.assertEquals(self.vm.get_qmp_events(wait=False), [])
> +        self.assertEqual(self.vm.get_qmp_events(wait=False), [])
>   
>           result = self.vm.qmp('query-block')
>           self.assert_qmp(result, 'return[0]/inserted/ro', False)
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index 27bb2b600c..d537538ba0 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -581,7 +581,7 @@ class QMPTestCase(unittest.TestCase):
>       def wait_ready_and_cancel(self, drive='drive0'):
>           self.wait_ready(drive=drive)
>           event = self.cancel_and_wait(drive=drive)
> -        self.assertEquals(event['event'], 'BLOCK_JOB_COMPLETED')
> +        self.assertEqual(event['event'], 'BLOCK_JOB_COMPLETED')
>           self.assert_qmp(event, 'data/type', 'mirror')
>           self.assert_qmp(event, 'data/offset', event['data']['len'])
>   
> 
