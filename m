Received: from eggs.gnu.org ([2001:4830:134:3::10]:42821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fALVU-0002Xl-8y
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 16:22:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fALVR-0002Nv-4K
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 16:22:44 -0400
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236]:44699)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fALVQ-0002Mm-Sk
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 16:22:41 -0400
Received: by mail-pf0-x236.google.com with SMTP id p15so7478479pff.11
	for <qemu-devel@nongnu.org>; Sun, 22 Apr 2018 13:22:40 -0700 (PDT)
References: <20180419135901.30035-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ef2caf0d-4bd0-9383-5d2f-e1f0ba9f536b@linaro.org>
Date: Sun, 22 Apr 2018 10:22:34 -1000
MIME-Version: 1.0
In-Reply-To: <20180419135901.30035-1-alex.bennee@linaro.org>
Content-Type: multipart/mixed; boundary="------------B28DF8EA3BA36594FF0D642F"
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 00/43] fix building of tests/tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

This is a multi-part message in MIME format.
--------------B28DF8EA3BA36594FF0D642F
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 04/19/2018 03:58 AM, Alex Bennée wrote:
> What would be really
> helpful is if the respective maintainers could encode their EXACT
> STEPS for building their cross compilers into some docker recipes.

I've just re-built my alphaev67 cross-environment and recorded everything.

Since the script begins with rebuilding glibc, it assumes you *already* have a
cross-compiler.  If you don't have that, then you start in the middle of the
script with the GCC build.  But in that case you must have the sysroot.tar.gz
that the first half just created.

Starting without that seed tarball is hard, as previously mentioned.  For
better supported platforms than alpha you can typically pull the same files
from e.g. debian packages or a gentoo stage3 tarball.

While I've used git gcc/binutils/glibc, because I had them handy, of course
everything would work equally well using release tarballs for each project.

Let me know if you have any questions re cross-tools.


r~

--------------B28DF8EA3BA36594FF0D642F
Content-Type: application/x-shellscript;
 name="cross.sh"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="cross.sh"

S0VSTkVMX0FSQ0g9YWxwaGEKQ0NfQVJDSD1hbHBoYWV2NjctbGludXgKQ0NfSU5TVEFMTD0k
SE9NRS93b3JrL2djYy9ydW4tY3Jvc3MKQ0NfU1lTUk9PVD0kQ0NfSU5TVEFMTC8kQ0NfQVJD
SC9zeXMtcm9vdAoKIwojIEdMSUJDIGJ1aWxkIGFuZCBpbnN0YWxsCiMKCmNkIH4vd29yay9n
bGliYy9zcmMKZ2l0IHB1bGwKY2QgLi4vCm1rZGlyIGJsZApjZCBibGQKLi4vc3JjL2NvbmZp
Z3VyZSAtLXByZWZpeD0vdXNyIC0tZGlzYWJsZS1wcm9maWxlIC0td2l0aG91dC1zZWxpbnV4
IFwKCS0tZGlzYWJsZS13ZXJyb3IgLS1ob3N0PSRDQ19BUkNICm1ha2UgLWo4Cm1ha2UgaW5z
dGFsbCBERVNURElSPSRIT01FL3dvcmsvZ2xpYmMvaW5zCgojIEluc3RhbGwga2VybmVsIGhl
YWRlcnMgaW50byB0aGUgc2FtZSBzeXNyb290CgpjZCB+L3dvcmsvbGludXgvc3JjCmdpdCBw
dWxsCm1rZGlyIC4uL2JsZAptYWtlIEFSQ0g9JEtFUk5FTF9BUkNIIE89Li4vYmxkIGRlZmNv
bmZpZwptYWtlIEFSQ0g9JEtFUk5FTF9BUkNIIE89Li4vYmxkIFwKCUlOU1RBTExfSERSX1BB
VEg9JEhPTUUvd29yay9nbGliYy9pbnMvdXNyIFwKCWhlYWRlcnNfaW5zdGFsbAoKIyBDcmVh
dGUgc3lzcm9vdCB0YXJiYWxsCgpjZCB+L3dvcmsvbGliYy9pbnMKdGFyIGNmdnogfi9zeXNy
b290LnRhci5neiAuCgojCiMgR0NDIGJ1aWxkIGFuZCBpbnN0YWxsCiMKCmNkIH4vd29yay9n
Y2MvZ2l0LXNyYwkJIyBiaW51dGlscy1nZGIgZ2l0CmdpdCBwdWxsCmNkIH4vd29yay9nY2Mv
Z2l0LW1hc3RlcgkjIGdjYyBnaXQKLi9jb250cmliL2djY191cGRhdGUKY2QgLi4vCm1rZGly
IC1wIGNvbWIvaW5jbHVkZQpjZCBjb21iCmxuIC1zIC4uL2dpdC1tYXN0ZXIvKiAuCmxuIC1z
IC4uL2dpdC1zcmMvKiAuCmNkIGluY2x1ZGUKbG4gLXMgLi4vLi4vZ2l0LW1hc3Rlci9pbmNs
dWRlLyogLgpsbiAtcyAuLi8uLi9naXQtc3JjL2luY2x1ZGUvKiAuCmNkIC4uLy4uLwpta2Rp
ciAtcCAkQ0NfU1lTUk9PVApjZCAkQ0NfU1lTUk9PVAp0YXIgenhmdiB+L3N5c3Jvb3QudGFy
Lmd6CmNkIC4uCmxuIC1zIHN5cy1yb290L3Vzci9pbmNsdWRlCmxuIC1zIHN5cy1yb290L3Vz
ci9saWIKY2Qgfi93b3JrL2djYwpta2RpciBibGQKY2QgYmxkCi4uL2NvbWIvY29uZmlndXJl
IC0tcHJlZml4PSRDQ19JTlNUQUxMIC0td2l0aC1zeXNyb290IC0tdGFyZ2V0PSRDQ19BUkNI
Cm1ha2UgLWo4Cm1ha2UgaW5zdGFsbAoKCg==
--------------B28DF8EA3BA36594FF0D642F--
