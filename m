Received: from eggs.gnu.org ([2001:4830:134:3::10]:41896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eDJSW-0002I1-Du
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 19:15:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eDJSS-0000ZG-F0
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 19:15:40 -0500
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:44959)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eDJSS-0000Yd-5G
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 19:15:36 -0500
Received: by mail-pf0-x22f.google.com with SMTP id x7so7776275pfa.1
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 16:15:35 -0800 (PST)
References: <7967e55c-de72-6ef2-eb92-a85af8fc2552@redhat.com>
	<96ded936-f9e3-c712-291e-fcb3d44bbe65@amsat.org>
	<20171108130102.GS12670@redhat.com>
	<fd7bb230-bbe3-ce3c-3026-d3d51544a14a@ozlabs.ru>
	<20171110104135.GB30685@redhat.com>
	<a1d39dc8-72e1-55a6-7c36-4bbe8b6142fa@ozlabs.ru>
	<CAFEAcA-jsUSrcYknPrcF4CjEvkFfjaYYnHFL0G-0+k9vM3f8aw@mail.gmail.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <d97544cd-3484-9f06-beb2-9392a6a5c5bc@ozlabs.ru>
Date: Sat, 11 Nov 2017 11:15:28 +1100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-jsUSrcYknPrcF4CjEvkFfjaYYnHFL0G-0+k9vM3f8aw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Yet another git submodule rant
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>

On 11/11/17 01:01, Peter Maydell wrote:
> On 10 November 2017 at 13:46, Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>> And it will still be
>> better than changing the $SRC_PATH when a user specifically asked not to do
>> that by calling "./configure --source-path='.
> 
> I'm not terribly happy with the submodule stuff either, but
> that configure rune is not making use of a documented
> or supported feature. --source-path is for telling configure
> where the source code is. Passing it an empty string should
> probably be rejected as an error.


It is not empty, I just cut an example too much :) The script looks like:

cd /home/aik/pbuild/qemu-garrison2-ppc64/
/home/aik/p/qemu/configure --target-list=ppc64-softmmu
--source-path=/home/aik/p/qemu/



-- 
Alexey
