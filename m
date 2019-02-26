Received: from eggs.gnu.org ([209.51.188.92]:40738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gyi5B-0002IW-NN
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 14:08:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gyi54-0003VH-7q
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 14:07:56 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:36210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gyi4t-0003PG-AA
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 14:07:44 -0500
Received: by mail-wm1-f54.google.com with SMTP id j125so3324101wmj.1
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 11:07:36 -0800 (PST)
References: <20190225123111.30363-1-berrange@redhat.com>
	<CAFEAcA9_AeKMZxrGE7pSp0j1JSSWTLCk2g7aP=QCtTWGNFposQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <41d3532c-0ab4-db82-dc9a-cc9fb45c6162@redhat.com>
Date: Tue, 26 Feb 2019 20:07:34 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9_AeKMZxrGE7pSp0j1JSSWTLCk2g7aP=QCtTWGNFposQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 00/11] Merge authz core patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

On 2/26/19 8:04 PM, Peter Maydell wrote:
> On Mon, 25 Feb 2019 at 12:35, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> The following changes since commit 8eb29f1bf5a974dc4c11d2d1f5e7c7f7a62be116:
>>
>>   Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-20190221.0' into staging (2019-02-22 15:48:04 +0000)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/berrange/qemu tags/authz-core-pull-request
>>
>> for you to fetch changes up to cfde05c6c0db7d3122a5491d50f62f7910ab8abb:
>>
>>   authz: delete existing ACL implementation (2019-02-25 12:28:25 +0000)
>>
>> ----------------------------------------------------------------
>> Add a standard authorization framework
>>
>> The current network services now support encryption via TLS and in some
>> cases support authentication via SASL. In cases where SASL is not
>> available, x509 client certificates can be used as a crude authorization
>> scheme, but using a sub-CA and controlling who you give certs to. In
>> general this is not very flexible though, so this series introduces a
>> new standard authorization framework.
>>
> 
> Applied, thanks.

Argh there is a v2... Daniel didn't NACK'd this one.
