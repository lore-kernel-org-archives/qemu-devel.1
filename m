Received: from eggs.gnu.org ([2001:4830:134:3::10]:51687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eBlZq-00017Y-V6
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:52:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eBlZm-0005hN-RU
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:52:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59784
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eBlZm-0005gi-Ls
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:52:46 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA6Hjvgu139302
	for <qemu-devel@nongnu.org>; Mon, 6 Nov 2017 12:52:42 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e2u51mtx8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 12:52:41 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 6 Nov 2017 10:52:41 -0700
References: <20171019075031.25507-1-rjones@redhat.com>
	<5888e39b-8f55-2d6b-afbe-da4727f23c2d@msgid.tls.msk.ru>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 6 Nov 2017 12:52:35 -0500
MIME-Version: 1.0
In-Reply-To: <5888e39b-8f55-2d6b-afbe-da4727f23c2d@msgid.tls.msk.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <90c15906-724b-fd8a-89eb-e012ea910623@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] tpm: Don't call tpm_cleanup unless
 CONFIG_TPM.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>, "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com, amarnath.valluri@intel.com, marcandre.lureau@gmail.com

On 11/06/2017 12:49 PM, Michael Tokarev wrote:
> 19.10.2017 10:50, Richard W.M. Jones wrote:
>> When compiling with --disable-tpm:
>>
>>    ../vl.o: In function `main':
>>    /home/rjones/d/qemu/vl.c:4908: undefined reference to `tpm_cleanup'
>>
>> This appears to have been introduced in commit c37cacabf228
>> ("tpm: Move tpm_cleanup() to right place").
>>
>> index 0723835bbf..dbfd06d4bc 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -4905,7 +4905,9 @@ int main(int argc, char **argv, char **envp)
>>       res_free();
>>   
>>       /* vhost-user must be cleaned up before chardevs.  */
>> +#ifdef CONFIG_TPM
>>       tpm_cleanup();
>> +#endif
> Maybe we can define it to an empty macro (or inline function) in
> the header file instead?

It's solved with a stub in stubs/tpm.c.

   Stefan


>
> /mjt
>
