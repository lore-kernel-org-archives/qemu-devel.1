Received: from eggs.gnu.org ([2001:4830:134:3::10]:60944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb5KB-0000RS-RQ
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:01:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb5K7-00024I-KD
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:01:19 -0500
Received: from mail-qt0-x235.google.com ([2607:f8b0:400d:c0d::235]:33592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb5K7-000242-Gj
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:01:15 -0500
Received: by mail-qt0-x235.google.com with SMTP id e2so14221030qti.0
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 06:01:15 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <151576265381.530.11340069578142610706@5adcb62bf0d6>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <77c2edfa-d9d0-64b6-fad0-571a628dc422@amsat.org>
Date: Mon, 15 Jan 2018 11:01:11 -0300
MIME-Version: 1.0
In-Reply-To: <151576265381.530.11340069578142610706@5adcb62bf0d6>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/7] docker: update Ubuntu and Fedora
 images, deprecate old ones
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, alex.bennee@linaro.org, pbonzini@redhat.com

On 01/12/2018 10:10 AM, no-reply@patchew.org wrote:
> Hi,
> 
> This series failed automatic build test. Please find the testing commands and
> their output below. If you have docker installed, you can probably reproduce it
> locally.
> 
> Type: series
> Message-id: 20180112125000.27256-1-f4bug@amsat.org
> Subject: [Qemu-devel] [PATCH 0/7] docker: update Ubuntu and Fedora images, deprecate old ones
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> set -e
> git submodule update --init dtc
> # Let docker tests dump environment info
> export SHOW_ENV=1
> export J=8
> time make docker-test-quick@centos6
> time make docker-test-build@min-glib
> time make docker-test-mingw@fedora
> # iotests is broken now, skip
> # time make docker-test-block@fedora
> === TEST SCRIPT END ===
[...]
> real	1m29.261s
> user	0m4.543s
> sys	0m3.680s
>   LD      docker-test-mingw@fedora.mo
> /bin/sh: cc: command not found
> make: *** [rules.mak:115: docker-test-mingw@fedora.mo] Error 127

Funny, I'll see how to fix that (using a SILENT make rule probably).

> 
> real	0m0.194s
> user	0m0.095s
> sys	0m0.099s
> === OUTPUT END ===
> 
> Test command exited with code: 2
