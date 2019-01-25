Received: from eggs.gnu.org ([209.51.188.92]:59951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmyRh-0001t9-VN
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:10:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmyRg-0003uw-0E
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:10:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gmyRf-0003sY-OL
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:10:43 -0500
Date: Fri, 25 Jan 2019 10:10:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190125101032.GA4498@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <003301d4b494$775585c0$66009140$@ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <003301d4b494$775585c0$66009140$@ru>
Subject: Re: [Qemu-devel] Querying possible -cpu variants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, =?utf-8?B?J9Ck0YPRgNGB0L7QstCwINCd0LDRgtCw0LvQuNGPJw==?= <Natalia.Fursova@ispras.ru>, mdroth@linux.vnet.ibm.com

On Fri, Jan 25, 2019 at 12:58:04PM +0300, Pavel Dovgalyuk wrote:
> Hello.
> 
>  
> 
> We are making GUI for QEMU (which also should allow convenient record/replay command line
> generation): https://github.com/ispras/qemu-gui
> 
>  
> 
> To fill the combo box in CPU selection form we run QEMU with "-cpu help" command and parse its
> output.
> 
> The format of this list depends on target. Therefore our parsing code does not look good (and also
> may corrupt someday).
> 
>  
> 
> Is there a better way of requesting this information?
> 
>  
> 
> Or we should do one of the following:
> 
> 1.       Patch all targets and make the uniform "-cpu help" output format

Machine parsing of "help" output is not supported by the QEMU project.
This must all be done via the QMP interfaces.

> 2.       Add QMP command for requesting this list.

This already exists as the 'query-cpu-definitions' command


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
