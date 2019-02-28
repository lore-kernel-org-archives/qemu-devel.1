Received: from eggs.gnu.org ([209.51.188.92]:45514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gzOK9-0005OL-KE
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:14:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gzOK8-0000TY-Cw
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:14:17 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gzOK8-0000RW-2D
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:14:16 -0500
Received: by mail-wm1-f67.google.com with SMTP id j125so9522021wmj.1
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 08:14:12 -0800 (PST)
References: <20190228145624.24885-1-peter.maydell@linaro.org>
	<20190228145624.24885-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5d0eca90-1316-25a3-42d4-35f7dc5566be@redhat.com>
Date: Thu, 28 Feb 2019 17:14:09 +0100
MIME-Version: 1.0
In-Reply-To: <20190228145624.24885-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 01/11] docs/cpu-hotplug.rst: Fix rST
 markup issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>

On 2/28/19 3:56 PM, Peter Maydell wrote:
> sphinx-build complains:
> 
> docs/cpu-hotplug.rst:67: ERROR: Unexpected indentation.
> docs/cpu-hotplug.rst:69: ERROR: Unexpected indentation.
> docs/cpu-hotplug.rst:74: WARNING: Block quote ends without a blank line; unexpected unindent.
> docs/cpu-hotplug.rst:75: WARNING: Block quote ends without a blank line; unexpected unindent.
> docs/cpu-hotplug.rst:76: SEVERE: Unexpected section title.
> 
> }
> {
> docs/cpu-hotplug.rst:78: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> These are the result of not indicating one of the literal
> blocks by finishing the preceding paragraph with the "::" marker.

I applied your series then revert this patch to test how failures are
handled. On rebuild nothing happend, I was worried about caching then
remember something in your cover, read it again and understood this file
is not in watched directory so not generated.

Then I moved this file in a watched dir. I see warnings are not fatal,
and from the manpage there is the '-W' option:

  sphinx-build(1)

  -W     Turn warnings into errors.
         This means that the build stops at the first warning
         and sphinx-build exits with exit status 1.

Can we use this by default, as of C warnings?

This should be our default on the CI builds anyway.

Meanwhile for this patch:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  docs/cpu-hotplug.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/cpu-hotplug.rst b/docs/cpu-hotplug.rst
> index 1c268e00b41..e2d4e893b01 100644
> --- a/docs/cpu-hotplug.rst
> +++ b/docs/cpu-hotplug.rst
> @@ -60,7 +60,7 @@ vCPU hotplug
>      hot-plugged (no "qom-path" member).  From its output in step (3), we
>      can see that ``IvyBridge-IBRS-x86_64-cpu`` is present in socket 0,
>      while hot-plugging a CPU into socket 1 requires passing the listed
> -    properties to QMP ``device_add``:
> +    properties to QMP ``device_add``::
>  
>        (QEMU) device_add id=cpu-2 driver=IvyBridge-IBRS-x86_64-cpu socket-id=1 core-id=0 thread-id=0
>        {
> 
