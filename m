Received: from eggs.gnu.org ([2001:4830:134:3::10]:60683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1da0pM-0005Ak-3Y
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:28:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1da0pI-0002Ze-W5
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:28:48 -0400
Received: from mail-qt0-x22d.google.com ([2607:f8b0:400d:c0d::22d]:37686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1da0pI-0002ZM-RI
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:28:44 -0400
Received: by mail-qt0-x22d.google.com with SMTP id r14so54550867qte.4
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 07:28:44 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20170725133425.436-1-alex.bennee@linaro.org>
	<20170725133425.436-6-alex.bennee@linaro.org>
	<37c12235-eec1-b960-6053-0414ebac0aae@amsat.org>
Message-ID: <e8996860-56ac-e8bf-2116-619fb3d48f9a@amsat.org>
Date: Tue, 25 Jul 2017 11:28:41 -0300
MIME-Version: 1.0
In-Reply-To: <37c12235-eec1-b960-6053-0414ebac0aae@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 v2 5/6] docker: don't install
 device-tree-compiler build-deps in travis.docker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, famz@redhat.com
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org

On 07/25/2017 11:17 AM, Philippe Mathieu-Daudé wrote:
> before:
> 
> $ docker images qemu:travis --no-trunc 
> --format="{{.Repository}}:{{.Tag}}\t{{.Size}}"
> 
> qemu:travis    6.16GB
> 
> after:
> 
> qemu:travis    5.92GB

I mis-selected, the correct size this patch applied:

qemu:travis	6.03GB

> 
> not a big win :(
