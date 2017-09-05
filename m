Received: from eggs.gnu.org ([2001:4830:134:3::10]:38889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dp91f-00052W-Li
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 04:16:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dp91b-00061k-0X
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 04:16:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dp91a-000614-Pt
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 04:15:58 -0400
References: <1504545540-8002-1-git-send-email-peter.maydell@linaro.org>
	<d91a4033-a76a-9adc-aaa0-ded8468a337b@redhat.com>
	<20170905080418.GA311@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f176ca29-3de0-ea3c-fe0a-1f5b3c283581@redhat.com>
Date: Tue, 5 Sep 2017 10:15:54 +0200
MIME-Version: 1.0
In-Reply-To: <20170905080418.GA311@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] configure: Drop AIX host support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, patches@linaro.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Laurent Vivier <laurent@vivier.eu>

On 05.09.2017 10:04, Daniel P. Berrange wrote:
> On Mon, Sep 04, 2017 at 08:09:17PM +0200, Thomas Huth wrote:
>> On 04.09.2017 19:19, Peter Maydell wrote:
>>> Nobody has mentioned AIX host support on the mailing list for years,
>>> and we have no test systems for it so it is most likely broken.
>>> We've advertised in configure for two releases now that we plan
>>> to drop support for this host OS, and have had no complaints.
>>
>> We just added this some weeks ago to our qemu-doc.texi:
>>
>> "Prior to the 2.10.0 release there was no official policy on how long
>> features would be deprecated prior to their removal, nor any documented
>> list of which features were deprecated. Thus any features deprecated
>> prior to 2.10.0 will be treated as if they were first deprecated in the
>> 2.10.0 release."
>>
>> Should we maybe wait two more releases (for version 3.0 ;-)) 'till we
>> remove it?
> 
> The deprecation policy is for features which currently work and which we
> expect to have actual users. Neither is the case with AIX support, so I
> don't see any reason to keep it longer.

OK, then let's remove the dead AIX code in 2.11 already!

 Thomas
