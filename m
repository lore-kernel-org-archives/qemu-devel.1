Received: from eggs.gnu.org ([2001:4830:134:3::10]:41842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fGAtm-0003hV-Mc
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fGAtj-0001xk-IT
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:54 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fGAtj-0001w7-CI
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:51 -0400
Received: by mail-wm0-f67.google.com with SMTP id y189-v6so5984430wmc.3
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 15:15:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
References: <20180418075045.27393-1-olaf@aepfle.de>
	<41df38a4-dc02-7c17-4877-26541fddd209@redhat.com>
Message-ID: <d058d5e6-710b-2f34-9828-9ddde18069a1@redhat.com>
Date: Wed, 9 May 2018 00:15:42 +0200
MIME-Version: 1.0
In-Reply-To: <41df38a4-dc02-7c17-4877-26541fddd209@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] configure: recognize more rpmbuild
 macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olaf Hering <olaf@aepfle.de>, qemu-trivial@nongnu.org
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 18/04/2018 11:23, Paolo Bonzini wrote:
> On 18/04/2018 09:50, Olaf Hering wrote:
>> Extend the list of recognized, but ignored options from rpms %configure
>> macro. This fixes build on hosts running SUSE Linux.
>>
>> Signed-off-by: Olaf Hering <olaf@aepfle.de>
>> ---
>>  configure | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/configure b/configure
>> index 0a19b033bc..6e9b994f21 100755
>> --- a/configure
>> +++ b/configure
>> @@ -959,6 +959,9 @@ for opt do
>>    ;;
>>    --firmwarepath=*) firmwarepath="$optarg"
>>    ;;
>> +  --host=*|--build=*|\
>> +  --program-prefix=*|--exec-prefix=*|\
>> +  --disable-dependency-tracking|\

Actually, --program-prefix= and --exec-prefix= have a meaning, they
cannot just be ignored.  For now I've removed this line; what is the
exact incantation used by SUSE Linux?

Thanks,

Paolo

>>    --sbindir=*|--sharedstatedir=*|\
>>    --oldincludedir=*|--datarootdir=*|--infodir=*|--localedir=*|\
>>    --htmldir=*|--dvidir=*|--pdfdir=*|--psdir=*)
>>
> 
> Queued, thanks.
> 
> Paolo
> 
