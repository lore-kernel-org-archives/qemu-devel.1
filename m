Received: from eggs.gnu.org ([2001:4830:134:3::10]:47685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f3xso-0000Rp-Ru
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 01:56:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f3xsk-0000kI-Ir
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 01:56:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51116 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f3xsk-0000jw-Co
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 01:56:22 -0400
References: <mailman.35816.1522678020.27992.qemu-devel@nongnu.org>
	<B4011235-0338-474D-90E4-ABDF3DC8CCB7@gmail.com>
	<eeb9a3c8-e7ee-742b-fd6a-41c364d971c4@redhat.com>
	<57D8CDA1-C9D1-4CD7-99A1-203B570BF4D3@gmail.com>
	<20180404143859.GI3186@redhat.com>
	<e283ef1f-a1cd-c21a-9058-c68c76182486@redhat.com>
	<20180404145803.GJ3186@redhat.com>
	<b5f3cb9f-d40a-439a-34a4-58bba9ec0387@weilnetz.de>
	<6171cf9f-6c76-33a7-9654-c6ed78dbe02f@redhat.com>
	<64bdd5df-c7c0-fe1b-4622-680cee1a13bb@weilnetz.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e6c8a94b-58e7-0220-6748-7954fe590747@redhat.com>
Date: Thu, 5 Apr 2018 07:56:10 +0200
MIME-Version: 1.0
In-Reply-To: <64bdd5df-c7c0-fe1b-4622-680cee1a13bb@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-web PATCH] download: Add instructions for
 MacPorts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Programmingkid <programmingkidx@gmail.com>, Rainer M?ller <raimue@macports.org>, QEMU Developers <qemu-devel@nongnu.org>

On 04/04/2018 19:41, Stefan Weil wrote:
> Am 04.04.2018 um 18:11 schrieb Paolo Bonzini:
>> On 04/04/2018 17:55, Stefan Weil wrote:
>>> By the way: https://qemu.weilnetz.de provides https (maybe I should
>>> enforce it), it includes sha512, and I also sign the binaries with my
>>> key. You still have to trust me, Debian and Cygwin (which provides lots
>>> of libraries used for the build).
>>
>> Cool!  I had noticed sha512, but it is not very useful without https
>> (except to verify bitflips).  Good news that you support https, we
>> should change the website to use https links instead.
>>
>> Regarding signing, there is no GPG signature.  That's okay, but we
>> should document how to verify the installer signature from either Linux
>> or Windows.
>>
>> Thanks,
>>
>> Paolo
> 
> 
> The executables (installer, installed exe files) are signed using
> osslsigncode (https://packages.debian.org/sid/otherosfs/osslsigncode)
> and my personal CACert key for code signing.
> 
> The signatures can be checked on Windows (e.g. during the installation
> process or from Windows Explorer with file properties) or on Linux (see
> example below). That's Windows standard. The only problem is that
> Windows does not automatically accept CACert keys (and that I have no
> better key for code signing).

Very good, thanks.  I'll add that information to the wiki.

Paolo

> Stefan
> 
> 
> $ osslsigncode verify /var/www/html/w32/qemu-w32-setup-20180321.exe
> Current PE checksum   : 04D7CD55
> Calculated PE checksum: 04D7CD55
> 
> Message digest algorithm  : SHA1
> Current message digest    : B2B13EB4765B4708D999BE3E4893915BBCAB0F8E
> Calculated message digest : B2B13EB4765B4708D999BE3E4893915BBCAB0F8E
> 
> Signature verification: ok
> 
> Number of signers: 1
> 	Signer #0:
> 		Subject: /CN=Stefan Weil/emailAddress=sw@weilnetz.de
> 		Issuer : /O=Root CA/OU=http://www.cacert.org/CN=CA Cert Signing
> Authority/emailAddress=support@cacert.org
> 		Serial : 0D6AA6
> 
> Number of certificates: 2
> 	Cert #0:
> 		Subject: /CN=Stefan Weil/emailAddress=sw@weilnetz.de
> 		Issuer : /O=Root CA/OU=http://www.cacert.org/CN=CA Cert Signing
> Authority/emailAddress=support@cacert.org
> 		Serial : 0D6AA6
> 	------------------
> 	Cert #1:
> 		Subject: /O=Root CA/OU=http://www.cacert.org/CN=CA Cert Signing
> Authority/emailAddress=support@cacert.org
> 		Issuer : /O=Root CA/OU=http://www.cacert.org/CN=CA Cert Signing
> Authority/emailAddress=support@cacert.org
> 		Serial : 0
> 
> Succeeded
> 
