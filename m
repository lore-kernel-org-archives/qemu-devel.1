Received: from eggs.gnu.org ([2001:4830:134:3::10]:53204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gXs6n-0000t5-Lj
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 13:22:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gXs6j-0005l6-LX
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 13:22:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1gXs6h-0005jH-I2
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 13:22:40 -0500
References: <20181214094828.18343-1-pbonzini@redhat.com>
	<6e191a36-7283-ed82-5f1f-3a8f4f818d62@redhat.com>
	<48697d08-5230-bba3-7de9-2aef7054a7ed@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <318c6986-2699-79fd-90cd-b8a61e2ee725@redhat.com>
Date: Fri, 14 Dec 2018 16:22:33 -0200
MIME-Version: 1.0
In-Reply-To: <48697d08-5230-bba3-7de9-2aef7054a7ed@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] scripts: add script to convert
 multiline comments into 4-line format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, armbru@redhat.com


On 12/14/2018 04:15 PM, Paolo Bonzini wrote:
> On 14/12/18 19:06, Wainer dos Santos Moschetta wrote:
>> IIUC above block handles the lines between lead and trail. So it would
>> fix (but it doesn't) this:
>>
>> # cat foo
>> /*
>>  =C2=A0comment 1
>>  =C2=A0comment 2
>>  =C2=A0*/
>>
>> # scripts/fix-multiline-comments.sh foo
>> /*
>>  =C2=A0comment 1
>>  =C2=A0comment 2
>>  =C2=A0*/
> Not enough spaces :)  It would fix
>
>   /*
>      comment 1
>      comment 2
>    */
>
> or what is actually found in QEMU:
>
>     /* comment 1
>        comment 2 */

I tried hard but I failed to find problems. :)

Thus,

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>


>
> Thanks,
>
> Paolo
