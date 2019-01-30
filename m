Received: from eggs.gnu.org ([209.51.188.92]:55124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gosq5-0007mP-6g
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 11:35:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gosq3-0000Yl-QM
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 11:35:49 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gosq1-0000Sv-Pu
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 11:35:47 -0500
Received: by mail-wm1-f66.google.com with SMTP id y8so177234wmi.4
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 08:35:38 -0800 (PST)
References: <20190130152434.17283-1-mreitz@redhat.com>
	<20190130152434.17283-3-mreitz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <82ddeb91-be6d-19e9-9c59-ce102e5d22b0@redhat.com>
Date: Wed, 30 Jan 2019 17:35:35 +0100
MIME-Version: 1.0
In-Reply-To: <20190130152434.17283-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 02/10] iotests: Fix 237 for Python 2.x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org

On 1/30/19 4:24 PM, Max Reitz wrote:
> math.ceil() returns an integer on Python 3.x, but a float on Python 2.x.
> range() always needs integers, so we need an explicit conversion on 2.x
> (which does not hurt on 3.x).
> 
> It is not quite clear whether we want to support Python 2.x for any
> prolonged time, but this may as well be fixed along with the other
> issues some iotests have right now.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/qemu-iotests/237 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qemu-iotests/237 b/tests/qemu-iotests/237
> index fe0dd0f461..06897f8c87 100755
> --- a/tests/qemu-iotests/237
> +++ b/tests/qemu-iotests/237
> @@ -224,7 +224,7 @@ with iotests.FilePath('t.vmdk') as disk_path, \
>              iotests.log("= %s %d =" % (subfmt, size))
>              iotests.log("")
>  
> -            num_extents = math.ceil(size / 2.0**31)
> +            num_extents = int(math.ceil(size / 2.0**31))
>              extents = [ "ext%d" % (i) for i in range(1, num_extents + 1) ]
>  
>              vm.launch()
> 
