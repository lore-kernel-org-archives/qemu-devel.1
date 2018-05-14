Received: from eggs.gnu.org ([2001:4830:134:3::10]:57735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fI8Km-0007Ws-O8
	for qemu-devel@nongnu.org; Mon, 14 May 2018 03:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fI8Kh-00047z-TQ
	for qemu-devel@nongnu.org; Mon, 14 May 2018 03:55:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53338 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fI8Kh-000474-PS
	for qemu-devel@nongnu.org; Mon, 14 May 2018 03:55:47 -0400
References: <1525111345-14606-1-git-send-email-thuth@redhat.com>
	<20180503122122.GG5301@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <56637a3e-1566-2385-8dec-7fb3bf8c5fc2@redhat.com>
Date: Mon, 14 May 2018 15:55:40 +0800
MIME-Version: 1.0
In-Reply-To: <20180503122122.GG5301@stefanha-x1.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 0/3] net: Get rid of 'vlan'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Samuel Thibault <samuel.thibault@ens-lyon.org>



On 2018=E5=B9=B405=E6=9C=8803=E6=97=A5 20:21, Stefan Hajnoczi wrote:
> On Mon, Apr 30, 2018 at 08:02:22PM +0200, Thomas Huth wrote:
>> The 'vlan' term caused a lot of confusion and misconfigurations in the
>> past. The parameter has been marked as deprecated since QEMU v2.9.0, s=
o
>> it's now time to finally remove the parameter and use the better word =
"hub"
>> in the remaining spots that actually mean the QEMU emulated hub featur=
e.
>>
>> v4:
>>   - Some rewordings in qemu-doc.texi and qemu-options.hx according to
>>     Stefan's and Paolo's suggestions
>>
>> v3:
>>   - Some rewordings in qemu-doc and net.json according to Paolo's sugg=
estions
>>
>> v2:
>>   - Added first patch to actually remove the deprecated 'vlan' paramet=
er
>>     (instead of only updating the wording in the sources and docs)
>>
>> Thomas Huth (3):
>>    net: Remove the deprecated "vlan" parameter
>>    net: Get rid of 'vlan' terminology and use 'hub' instead in the sou=
rce
>>      files
>>    net: Get rid of 'vlan' terminology and use 'hub' instead in the doc
>>      files
>>
>>   docs/qdev-device-use.txt         |  3 --
>>   hw/core/qdev-properties-system.c | 80 ------------------------------=
----------
>>   include/hw/qdev-properties.h     |  3 --
>>   include/net/net.h                |  1 -
>>   net/hub.c                        |  7 ++--
>>   net/net.c                        | 12 ++----
>>   net/slirp.c                      |  8 ++--
>>   net/tap.c                        |  4 +-
>>   qapi/net.json                    | 15 ++++----
>>   qemu-doc.texi                    | 51 ++++++++++++-------------
>>   qemu-options.hx                  | 29 ++++++---------
>>   11 files changed, 54 insertions(+), 159 deletions(-)
>>
>> --=20
>> 1.8.3.1
>>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Applied, thanks.
