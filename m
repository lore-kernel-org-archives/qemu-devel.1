Received: from eggs.gnu.org ([209.51.188.92]:55682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hL7va-0007hp-Bn
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hL7vZ-0000eg-4k
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:10:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hL7vY-0000dj-TN
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:10:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id n25so1343254wmk.4
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 08:10:44 -0700 (PDT)
References: <155655030568.10667.13700938703853199260@c2072b67cc0c>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <223a0019-d3c6-45de-1926-a84f5b595a9f@redhat.com>
Date: Mon, 29 Apr 2019 17:10:42 +0200
MIME-Version: 1.0
In-Reply-To: <155655030568.10667.13700938703853199260@c2072b67cc0c>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] usb/xchi: avoid trigger assertion if guest
 write wrong epid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, no-reply@patchew.org, longpeng2@huawei.com
Cc: fam@euphon.net, arei.gonglei@huawei.com, kraxel@redhat.com, patchew-devel@redhat.com

Hi Paolo, Fam.

On 4/29/19 5:05 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/1556523569-44480-1-git-send-email-longpeng2@huawei.com/
[...]
> This series failed the docker-mingw@fedora build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
[...]
> The full log is available at
> http://patchew.org/logs/1556523569-44480-1-git-send-email-longpeng2@huawei.com/testing.docker-mingw@fedora/?type=message.

Weird patchew error:

Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
>From https://github.com/patchew-project/qemu
 - [tag update]
patchew/1554321185-2825-1-git-send-email-sandra@codesourcery.com ->
patchew/1554321185-2825-1-git-send-email-sandra@codesourcery.com
 * [new tag]
patchew/1556523569-44480-1-git-send-email-longpeng2@huawei.com ->
patchew/1556523569-44480-1-git-send-email-longpeng2@huawei.com
[...]
error: rev-list died of signal 9
fatal: remote did not send all necessary objects
fatal: The remote end hung up unexpectedly

Traceback (most recent call last):
  File "patchew-tester/src/patchew-cli", line 521, in test_one
    git_clone_repo(clone, r["repo"], r["head"], logf, True)
  File "patchew-tester/src/patchew-cli", line 53, in git_clone_repo
    subprocess.check_call(clone_cmd, stderr=logf, stdout=logf)
  File "/usr/lib64/python3.4/subprocess.py", line 558, in check_call
    raise CalledProcessError(retcode, cmd)
