Received: from eggs.gnu.org ([2001:4830:134:3::10]:39931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eAhnt-0004nR-Fm
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 15:38:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eAhnq-0001qS-D4
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 15:38:57 -0400
Received: from mail-qt0-x231.google.com ([2607:f8b0:400d:c0d::231]:49428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eAhnq-0001pL-6w
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 15:38:54 -0400
Received: by mail-qt0-x231.google.com with SMTP id k31so4560772qta.6
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 12:38:54 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171103153333.6416-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8293752e-fd11-f550-cd88-2c1a85192e9b@amsat.org>
Date: Fri, 3 Nov 2017 16:38:49 -0300
MIME-Version: 1.0
In-Reply-To: <20171103153333.6416-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 0/5] Various improvements/bugfixes to
 submodule handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Peter Maydell <peter.maydell@linaro.org>

On 11/03/2017 12:33 PM, Daniel P. Berrange wrote:
> This short series of patches improves the reliability of the submodule
> handling to cope with various dev env scenarios that have since emerged
> 
>   v2: https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg06272.html
> 
> Changed in v3:
> 
>  - Avoid use of mktemp
>  - Use '=' instead of '==' (bashism) in conditional tests
>  - Fix problem with short-circuiting for empty submodule list
>  - Ensure help message is displayed on all errors
> 
> Daniel P. Berrange (5):
>   build: allow setting a custom GIT binary for transparent proxying
>   build: don't create temporary files in source dir
>   build: allow automatic git submodule updates to be disabled
>   build: don't fail if given a git submodule which does not exist
>   build: delay check for empty git submodule list

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
