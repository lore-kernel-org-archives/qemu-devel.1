Received: from eggs.gnu.org ([2001:4830:134:3::10]:39258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eAI7e-0003d2-T4
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:13:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eAI7b-0001B9-Ks
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:13:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eAI7b-00018r-Ep
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:13:35 -0400
References: <1509638660.11873.13.camel@redhat.com>
	<20171102161103.GU32533@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ac6dcd97-c94f-afda-e5cd-ba6542b03bfc@redhat.com>
Date: Thu, 2 Nov 2017 17:13:28 +0100
MIME-Version: 1.0
In-Reply-To: <20171102161103.GU32533@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] seabios serial console vs. sgabios
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: seabios <seabios@seabios.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 02/11/2017 17:11, Daniel P. Berrange wrote:
> Historically libvirt will always use '-device sgabios' if the user has
> requested <bios useserial='yes'/>.  So if that -device arg is given, I
> think QEMU must honour it, which implies QEMU must disable Seabios'
> own built-in serial console impl in that scenario.

We should also change libvirt to produce

  -device sga            (if sga supported)
  -machine graphics=off  (if -machine graphics supported)

On old QEMU, -machine graphics=off will be ignored.  On new QEMU and/or
SeaBIOS, we should ensure that specifying both has the right effect.

Paolo
