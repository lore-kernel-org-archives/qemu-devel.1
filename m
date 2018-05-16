Received: from eggs.gnu.org ([2001:4830:134:3::10]:49765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fIzeL-0005kj-My
	for qemu-devel@nongnu.org; Wed, 16 May 2018 12:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fIzeK-0003xj-Qh
	for qemu-devel@nongnu.org; Wed, 16 May 2018 12:51:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56942 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fIzeK-0003xB-Mo
	for qemu-devel@nongnu.org; Wed, 16 May 2018 12:51:36 -0400
References: <1525453270-23074-1-git-send-email-thuth@redhat.com>
	<1525453270-23074-3-git-send-email-thuth@redhat.com>
	<20180516164900.GA32582@perard.uk.xensource.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b75b0a14-b118-6f29-9050-d291e18ac165@redhat.com>
Date: Wed, 16 May 2018 18:51:32 +0200
MIME-Version: 1.0
In-Reply-To: <20180516164900.GA32582@perard.uk.xensource.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/5] qemu-options: Bail out on
 unsupported options instead of silently ignoring them
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Michal Privoznik <mprivozn@redhat.com>

On 16.05.2018 18:49, Anthony PERARD wrote:
> On Fri, May 04, 2018 at 07:01:07PM +0200, Thomas Huth wrote:
>> diff --git a/vl.c b/vl.c
>> index 806eec2..457e93b 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -4042,7 +4042,10 @@ int main(int argc, char **argv, char **envp)
>>                  }
>>                  break;
>>              default:
>> -                os_parse_cmd_args(popt->index, optarg);
>> +                if (os_parse_cmd_args(popt->index, optarg)) {
>> +                    error_report("Option not supported in this build");
>> +                    exit(1);
>> +                }
> 
> I think that report false errors, I've got:
> qemu-system-i386: -no-user-config: Option not supported in this build

Yes, sorry for that. Patch is already on the way:

https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg02972.html

 Thomas
